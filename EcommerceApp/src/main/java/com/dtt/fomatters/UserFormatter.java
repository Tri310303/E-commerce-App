package com.dtt.fomatters;

import com.dtt.pojo.User;
import org.springframework.format.Formatter;

import java.text.ParseException;
import java.util.Locale;

public class UserFormatter implements Formatter<User> {
    @Override
    public User parse(String id, Locale locale) throws ParseException {
        User o =new User();
        o.setId(Integer.parseInt(id))   ;
        return o;
    }

    @Override
    public String print(User user, Locale locale) {
        return String.valueOf(user.getId());
    }
}
