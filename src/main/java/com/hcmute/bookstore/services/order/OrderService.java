package com.hcmute.bookstore.services.order;

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
import org.springframework.web.bind.annotation.PathVariable;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Optional;

@Service
@AllArgsConstructor
public class OrderService implements IOrderService{
    private final OrderRepository orderRepository;
    private final OrderItemRepository orderItemRepository;
    private final ProductImageRepository productImageRepository;
    private final ProductRepository productRepository;
    @Override
    public String makeOrder(HttpServletRequest request, HttpServletResponse response, int id) {
        HttpSession session = request.getSession();
        boolean checkAuth = (boolean) session.getAttribute("auth");
        String roleAuth = (String) session.getAttribute("role");
        if (checkAuth && roleAuth.equals(Constant.ROLE_CUSTOMER)) {
            Optional<Order> order = orderRepository.isUserHasCart(id);
            double totalPrice = 0;
            if(order.isPresent()) {
                List<OrderItem> orderItems = orderItemRepository.findCartById(order.get().getId());
                for (OrderItem o: orderItems) {
                    ProductImage productImage = productImageRepository.findImageByProID(o.getProductId()).get(0);
                    o.setImage(productImage.getImg_src());
                    totalPrice += (o.getPrice()-(o.getPrice()*o.getDiscount()/100))*o.getQuantity();
                }
                request.setAttribute("orderItems", orderItems);
                request.setAttribute("totalPrice",totalPrice);
                return "viewOrder/MakeOrder";
            }
            else{
                request.setAttribute("hasError", true);
                request.setAttribute("errorMessage", "Has Error When Click Button");
                return "viewCart/Cart";
            }
        } else {
            return "redirect:/Home";
        }
    }

    @Override
    public String completeOrder(HttpServletRequest request, HttpServletResponse response, int id) throws IOException {
        String address = request.getParameter("address");
        List<OrderItem> orderItems = orderItemRepository.findCartById(id);
        double total=0;
        if(orderItems.size() > 0){
            for (OrderItem orderItem : orderItems) {
                total+=(orderItem.getPrice()-(orderItem.getPrice()*orderItem.getDiscount()/100))*orderItem.getQuantity();
            }
            Optional<Order> order = orderRepository.findById(id);
            order.get().setTotalPrice(total);
            order.get().setState(Constant.ORDERED);
            order.get().setAddress(address);
            orderRepository.save(order.get());
            List<OrderItem> orderItemsList = orderItemRepository.findCartById(id);
            for (OrderItem o: orderItemsList) {
                ProductImage productImage = productImageRepository.findImageByProID(o.getProductId()).get(0);
                o.setImage(productImage.getImg_src());
            }
            request.setAttribute("orderItems", orderItemsList);
            request.setAttribute("totalPrice",total);
            request.setAttribute("hasNotify", true);
            request.setAttribute("successMessage", "Order Successfully");
            return "viewOrder/MakeOrder";
        }else{
            List<OrderItem> orderItemsList = orderItemRepository.findCartById(id);
            for (OrderItem o: orderItemsList) {
                total+=(o.getPrice()-(o.getPrice()*o.getDiscount()/100))*o.getQuantity();
                ProductImage productImage = productImageRepository.findImageByProID(o.getProductId()).get(0);
                o.setImage(productImage.getImg_src());
            }
            request.setAttribute("orderItems", orderItemsList);
            request.setAttribute("hasError", true);
            request.setAttribute("errorMessage", "Cannot Make Order");
            return "viewOrder/MakeOrder";
        }
    }

    @Override
    public String showOrder(HttpServletRequest request, int id) {
        HttpSession session = request.getSession();
        boolean checkAuth = (boolean) session.getAttribute("auth");
        String roleAuth = (String) session.getAttribute("role");
        if (checkAuth && roleAuth.equals(Constant.ROLE_CUSTOMER)) {
            List<Order> orders = orderRepository.getOrderOfUser(id);
            request.setAttribute("orders",orders);
            return "viewOrder/ViewOrder";
        }else{
            return "redirect:/Home";
        }
    }

    @Override
    public String getOrder(HttpServletRequest request, HttpServletResponse response, int id) throws IOException {
        List<OrderItem> orderItems = orderItemRepository.findCartById(id);
        double total=0;
        if(orderItems.size()>0){
            for (OrderItem o: orderItems) {
                total+=(o.getPrice()-(o.getPrice()*o.getDiscount()/100))*o.getQuantity();
                ProductImage productImage = productImageRepository.findImageByProID(o.getProductId()).get(0);
                o.setImage(productImage.getImg_src());
            }
            request.setAttribute("totalPrice",total);
            request.setAttribute("orderItems",orderItems);
            return "viewOrder/ShowOrder";
        }
        else{
            return "204";
        }
    }

    @Override
    public void doneOrder(HttpServletRequest request, HttpServletResponse response, int id) throws IOException {
        Optional<Order> order = orderRepository.getOrder(id);
        if(order.isPresent()){
            order.get().setState(Constant.DONE);
            orderRepository.save(order.get());
            PrintWriter out = response.getWriter();
            response.setContentType("application/json");
            response.setCharacterEncoding("utf-8");
            out.print(true);
            out.flush();
        }else{
            PrintWriter out = response.getWriter();
            response.setContentType("application/json");
            response.setCharacterEncoding("utf-8");
            out.print(false);
            out.flush();
        }
    }

    @Override
    public void cancelOrder(HttpServletRequest request, HttpServletResponse response, int id) throws IOException {
        Optional<Order> order = orderRepository.getOrder(id);
        if(order.isPresent()){
            if(order.get().getState().equals(Constant.ORDERED)){
                order.get().setState(Constant.CANCELED);
                orderRepository.save(order.get());
                PrintWriter out = response.getWriter();
                response.setContentType("application/json");
                response.setCharacterEncoding("utf-8");
                out.print(true);
                out.flush();
            }else if(order.get().getState().equals(Constant.ACCEPTED)){
                List<OrderItem> orderItems = orderItemRepository.findCartById(id);
                int pro_id;
                if(orderItems.size() > 0) {
                    for (OrderItem orderItem : orderItems) {
                        pro_id = orderItem.getProductId();
                        Optional<Product> product = productRepository.findById(pro_id);
                        if(product.isPresent()){
                            product.get().setQuantity(product.get().getQuantity() + orderItem.getQuantity());
                            productRepository.save(product.get());
                        }
                    }
                }
                order.get().setState(Constant.CANCELED);
                orderRepository.save(order.get());
                PrintWriter out = response.getWriter();
                response.setContentType("application/json");
                response.setCharacterEncoding("utf-8");
                out.print(true);
                out.flush();
            }
        }else{
            PrintWriter out = response.getWriter();
            response.setContentType("application/json");
            response.setCharacterEncoding("utf-8");
            out.print(false);
            out.flush();
        }
    }
}

