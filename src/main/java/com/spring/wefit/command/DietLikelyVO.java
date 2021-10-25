package com.spring.wefit.command;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/*
 * CREATE TABLE DietLikely
(
    dbNum    NUMBER(10, 0)    NOT NULL, 
    memberNum    NUMBER(20, 0)    NOT NULL
); 

*/

@Getter
@Setter
@ToString
public class DietLikelyVO {
	
	private int dbNum;
	private int memberNum;
	
	
}




