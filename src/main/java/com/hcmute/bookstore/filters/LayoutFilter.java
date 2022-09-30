package com.hcmute.bookstore.filters;

import com.hcmute.bookstore.models.Category;
import com.hcmute.bookstore.repository.CategoryRepository;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import java.io.IOException;
import java.util.List;

@Component
@WebFilter(filterName = "LayoutFilter",value = "/*")
@AllArgsConstructor
public class LayoutFilter implements Filter {
    public void init(FilterConfig config) throws ServletException {
    }
    public void destroy() {
    }
    private final CategoryRepository categoryRepository;
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {
        List<Category> categoriesParent = categoryRepository.findCategoryParent();
        request.setAttribute("categoriesParent",categoriesParent);
        List<Category> categoriesChild = categoryRepository.findCategoryChild();
        request.setAttribute("categoriesChild",categoriesChild);
        chain.doFilter(request, response);
    }
}
