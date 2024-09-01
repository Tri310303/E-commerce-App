package com.dtt.fomatters;

import com.dtt.pojo.Product;
import org.springframework.format.Formatter;

import java.text.ParseException;
import java.util.Locale;

public class ProductFormatter implements Formatter<Product> {
    @Override
    public Product parse(String id, Locale locale) throws ParseException {
        Product p = new Product();
        p.setId(Integer.parseInt(id));
        return p;
    }

    @Override
    public String print(Product product, Locale locale) {
        return String.valueOf(product.getId());
    }
}
