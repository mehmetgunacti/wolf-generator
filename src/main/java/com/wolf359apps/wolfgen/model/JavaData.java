package com.wolf359apps.wolfgen.model;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class JavaData {

    private String               name;
    private String               packageName;
    private String           groupId;
    private App.Entity.Field primaryKey;

}
