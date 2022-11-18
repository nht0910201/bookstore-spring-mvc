package com.hcmute.bookstore.services.cart;

import com.hcmute.bookstore.Config.Constant;
import com.hcmute.bookstore.models.Order;
import com.hcmute.bookstore.models.OrderItem;
import com.hcmute.bookstore.models.Product;
import com.hcmute.bookstore.models.ProductImage;
import com.hcmute.bookstore.repository.OrderItemRepository;
import com.hcmute.bookstore.repository.OrderRepository;
import com.hcmute.bookstore.repository.ProductImageRepository;
import com.hcmute.bookstore.repository.ProductRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Optional;

@Service
@AllArgsConstructor
public class CartService implements ICartService{
    private final OrderItemRepository orderItemRepository;
    private final OrderRepository orderRepository;
    private final ProductImageRepository productImageRepository;
    private final ProductRepository productRepository;
    @Override
    public String showCart(HttpServletRequest request,int id) {
        HttpSession session = request.getSession();
        boolean checkAuth = (boolean) session.getAttribute("auth");        String roleAuth = (String) session.getAttribute("role");
        if (checkAuth && roleAuth.equals(Constant.ROLE_CUSTOMER)) {
            Optional<Order> order = orderRepository.isUserHasCart(id);
            if(order.isPresent()) {
                List<OrderItem> orderItems = orderItemRepository.findCartById(order.get().getId());

                for (OrderItem o: orderItems) {
                    ProductImage productImage = productImageRepository.findImageByProID(o.getProductId()).get(0);
                    o.setImage(productImage.getImg_src());

                }
                request.setAttribute("orderItems", orderItems);

                return "viewCart/Cart";
            }
            else{
                Order newOrder = new Order(id,"unknown",0,Constant.CREATED);
                orderRepository.save(newOrder);
                return "viewHome/Index";
            }
        } else {
            return "redirect:/Home";
        }
    }

    @Override
    public void addToCart(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        boolean checkAuth = (boolean) session.getAttribute("auth");
        String roleAuth = (String) session.getAttribute("role");
        if (checkAuth && roleAuth.equals(Constant.ROLE_CUSTOMER)) {
            int pro_id = Integer.parseInt(request.getParameter("pro_id"),10);
            String pro_name = request.getParameter("pro_name");
            Double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"),10);
            int discount = Integer.parseInt(request.getParameter("discount"),10);
            int userId=Integer.parseInt(request.getParameter("user_id"),10);
            Optional<Order> check = orderRepository.isUserHasCart(userId);
            if (check.isEmpty())
            {
                Order order = new Order(userId,"unknown",0,Constant.CREATED);
                orderRepository.save(order);
                Optional<OrderItem> cart = orderItemRepository.findProductInCartById(pro_id,userId);
                if(cart.isPresent()){
                    PrintWriter out = response.getWriter();
                    response.setContentType("application/json");
                    response.setCharacterEncoding("utf-8");
                    out.print(false);
                    out.flush();
                }else {
                    check = orderRepository.isUserHasCart(userId);
                    Optional<Product> pro = productRepository.findProductByID(pro_id);
                    if(pro.get().getQuantity() < quantity){
                        PrintWriter out = response.getWriter();
                        response.setContentType("application/json");
                        response.setCharacterEncoding("utf-8");
                        out.print(false);
                        out.flush();
                    }else{
                        OrderItem newOrderItem = new OrderItem(pro_id,pro_name,quantity,price,discount,check.get().getId(),userId);
                        orderItemRepository.save(newOrderItem);
                        PrintWriter out = response.getWriter();
                        response.setContentType("application/json");
                        response.setCharacterEncoding("utf-8");
                        out.print(true);
                        out.flush();
                    }
                }
            }
            else
            {
                Optional<OrderItem> cart = orderItemRepository.findProductInCartById(pro_id,userId);
                if(cart.isPresent()){
                    PrintWriter out = response.getWriter();
                    response.setContentType("application/json");
                    response.setCharacterEncoding("utf-8");
                    out.print(false);
                    out.flush();
                }else {
                    Optional<Product> pro = productRepository.findProductByID(pro_id);
                    if(pro.get().getQuantity() < quantity){
                        PrintWriter out = response.getWriter();
                        response.setContentType("application/json");
                        response.setCharacterEncoding("utf-8");
                        out.print(false);
                        out.flush();
                    }else{
                        OrderItem newOrderItem = new OrderItem(pro_id,pro_name,quantity,price,discount,check.get().getId(),userId);
                        orderItemRepository.save(newOrderItem);
                        PrintWriter out = response.getWriter();
                        response.setContentType("application/json");
                        response.setCharacterEncoding("utf-8");
                        out.print(true);
                        out.flush();
                    }
                }
            }
        }
    }

    @Override
    public void updateItem(HttpServletRequest request, HttpServletResponse response, int id) throws IOException {
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        if(quantity == 0){
            deleteItem(request,response);
        }else {
            Optional<OrderItem> orderItem = orderItemRepository.findCartItemById(orderId, id);
            if (orderItem.isEmpty()) {
                PrintWriter out = response.getWriter();
                response.setContentType("application/json");
                response.setCharacterEncoding("utf-8");
                out.print(false);
                out.flush();
            } else {
                Optional<Product> product = productRepository.findProductByID(orderItem.get().getProductId());
                if(quantity > product.get().getQuantity()){

                    PrintWriter out = response.getWriter();
                    response.setContentType("application/json");
                    response.setCharacterEncoding("utf-8");
                    out.print(false);
                    out.flush();
                }else{
                    orderItem.get().setQuantity(quantity);
                    orderItemRepository.save(orderItem.get());
                    PrintWriter out = response.getWriter();
                    response.setContentType("application/json");
                    response.setCharacterEncoding("utf-8");
                    out.print(true);
                    out.flush();
                }
            }
        }
    }

    @Override
    public void deleteItem(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int proId=Integer.parseInt(request.getParameter("proId"));
        int userId=Integer.parseInt(request.getParameter("userId"));
        Optional<OrderItem> orderItem = orderItemRepository.findProductInCartById(proId,userId);
        orderItemRepository.delete(orderItem.get());
        boolean isAvailable = orderItemRepository.findProductInCartById(proId,userId).isPresent();
        if (isAvailable)
        {
            PrintWriter out = response.getWriter();
            response.setContentType("application/json");
            response.setCharacterEncoding("utf-8");
            out.print(false);
            out.flush();
        }else{
            PrintWriter out = response.getWriter();
            response.setContentType("application/json");
            response.setCharacterEncoding("utf-8");
            out.print(true);
            out.flush();
        }
    }
}
