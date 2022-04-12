package com.hcmute.mobilestore.filters;

import com.hcmute.mobilestore.models.Supplier;
import com.hcmute.mobilestore.repository.SupplierRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.servlet.*;
import javax.servlet.annotation.*;
import java.io.IOException;
@WebFilter(filterName = "LayoutFilter",urlPatterns = "/*")
public class LayoutFilter implements Filter {
    public void init(FilterConfig config) throws ServletException {
    }

    public void destroy() {
    }
    @Autowired
    SupplierRepository supplierRepository;
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {
        Iterable<Supplier> suppliers = supplierRepository.findAll();
        request.setAttribute("suppliers",suppliers);
        chain.doFilter(request, response);
    }
}
