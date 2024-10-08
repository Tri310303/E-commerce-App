package com.dtt.pojo;

import com.dtt.pojo.Category;
import com.dtt.pojo.Comment;
import com.dtt.pojo.OrderDetail;
import com.dtt.pojo.ProdTag;
import com.dtt.pojo.Store;
import java.util.Date;
import javax.annotation.processing.Generated;
import javax.persistence.metamodel.SetAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="org.eclipse.persistence.internal.jpa.modelgen.CanonicalModelProcessor", date="2024-06-24T07:22:39", comments="EclipseLink-2.7.9.v20210604-rNA")
@StaticMetamodel(Product.class)
public class Product_ { 

    public static volatile SingularAttribute<Product, String> image;
    public static volatile SingularAttribute<Product, String> description;
    public static volatile SingularAttribute<Product, Boolean> active;
    public static volatile SingularAttribute<Product, Store> storeId;
    public static volatile SetAttribute<Product, OrderDetail> orderDetailSet;
    public static volatile SingularAttribute<Product, String> manufacturer;
    public static volatile SingularAttribute<Product, Date> createdDate;
    public static volatile SetAttribute<Product, Comment> commentSet;
    public static volatile SetAttribute<Product, ProdTag> prodTagSet;
    public static volatile SingularAttribute<Product, Long> price;
    public static volatile SingularAttribute<Product, String> name;
    public static volatile SingularAttribute<Product, String> store_name;
    public static volatile SingularAttribute<Product, Integer> id;
    public static volatile SingularAttribute<Product, Category> categoryId;

}