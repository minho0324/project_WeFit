package com.spring.wefit.command;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class FreeReplyVO {
	/*
		 CREATE TABLE FreeReply ( 
		 	frNum NUMBER(10, 0) NOT NULL, 
		 	fbNum NUMBER(10, 0) NOT NULL, 
		 	frContent VARCHAR2(200) NOT NULL, 
		 	memberNum NUMBER(20, 0) NOT NULL, 
		 	frRegDate DATE DEFAULT SYSDATE NOT NULL,
		 	CONSTRAINT PK_FreeReply PRIMARY KEY (frNum) 
		 );
	
		CREATE SEQUENCE FreeReply_seq 
			START WITH 1 
			INCREMENT BY 1 
			MAXVALUE 10000000 
			NOCYCLE 
			NOCACHE;
	 */
	
	private int frNum;
	private int fbNum;
	private String frContent;
	private int memberNum;
	private Timestamp frRegDate;
	
	private String memberNick;
}
