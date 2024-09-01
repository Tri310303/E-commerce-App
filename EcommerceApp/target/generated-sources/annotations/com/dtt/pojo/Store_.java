package com.dtt.pojo;

import com.dtt.pojo.User;
import javax.annotation.processing.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="org.eclipse.persistence.internal.jpa.modelgen.CanonicalModelProcessor", date="2024-06-24T07:22:39", comments="EclipseLink-2.7.9.v20210604-rNA")
@StaticMetamodel(Store.class)
public class Store_ { 

    public static volatile SingularAttribute<Store, String> address;
    public static volatile SingularAttribute<Store, String> phone;
    public static volatile SingularAttribute<Store, String> name;
    public static volatile SingularAttribute<Store, Integer> id;
    public static volatile SingularAttribute<Store, User> managerId;
    public static volatile SingularAttribute<Store, String> email;

}