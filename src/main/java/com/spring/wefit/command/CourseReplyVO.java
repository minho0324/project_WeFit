package com.spring.wefit.command;

import java.sql.Timestamp;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/*
 CREATE TABLE CourseReply
(
    crNum        NUMBER(10, 0)    NOT NULL, 
    cbNum        NUMBER(10, 0)    NOT NULL, 
    crContent    VARCHAR2(200)    NOT NULL, 
    mNum        NUMBER(20, 0)    NOT NULL,
    crRegDate    DATE             DEFAULT SYSDATE NOT NULL, 
    CONSTRAINT PK_CourseReply PRIMARY KEY (crNum)
); 

CREATE SEQUENCE courseReply_seq 
    START WITH 1 
    INCREMENT BY 1 
    MAXVALUE 10000000
    NOCYCLE 
    NOCACHE;
 */

@Getter
@Setter
@ToString
public class CourseReplyVO {
	
	private int crNum;
	private int cbNum;
	private String crContent;
	private String memberNick;
	private int memberNum;
	private Timestamp crRegDate;
	
	private int crContentByte;


}
