package com.spring.wefit.command;
/*
CREATE TABLE DietReply ( 
drNum NUMBER(10, 0) NOT NULL, 
dbNum NUMBER(10, 0) NOT NULL, 
drContent VARCHAR2(200) NOT NULL, 
memberNum NUMBER(20, 0) NOT NULL, 
drRegDate DATE DEFAULT SYSDATE NOT NULL, 
CONSTRAINT PK_DietReply PRIMARY KEY (drNum) );
);

CREATE SEQUENCE dietReply_seq 
    START WITH 1 
    INCREMENT BY 1 
    MAXVALUE 10000000
    NOCYCLE 
    NOCACHE;
*/

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class DietBoardReplyVO {

	private int drNum;
	private int dbNum;
	private String drContent;
	private int memberNum;
	private int starScore;
	private Timestamp drRegDate;
	
	private String memberNick;
}








