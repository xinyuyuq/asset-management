package com.ruoyi.asset.handler;

import com.baomidou.mybatisplus.core.handlers.MetaObjectHandler;
import com.ruoyi.common.utils.SecurityUtils;
import org.apache.ibatis.reflection.MetaObject;
import org.springframework.stereotype.Component;

import java.util.Date;

@Component
public class FieldHandler implements MetaObjectHandler {

    @Override
    public void insertFill(MetaObject metaObject) {
        String username = SecurityUtils.getUsername();

        this.setFieldValByName("createBy",username,metaObject);
        this.setFieldValByName("updateBy",username,metaObject);
        this.setFieldValByName("createTime",new Date(),metaObject);
        this.setFieldValByName("updateTime",new Date(),metaObject);
        this.setFieldValByName("repairUser",username,metaObject);
    }

    @Override
    public void updateFill(MetaObject metaObject) {

        String username = SecurityUtils.getUsername();

        this.setFieldValByName("updateBy",username,metaObject);
        this.setFieldValByName("updateTime",new Date(),metaObject);
    }
}
