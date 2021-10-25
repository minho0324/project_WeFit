package com.spring.wefit.commons;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString //이거 나중에 지우기
public class PageVO {

		//사용자가 선택한 페이지 정보를 담을 변수.
		private int pageNum;
		private int countPerPage;
		
		//검색에 필요한 데이터를 변수로 선언.
		private String keyword;
		private String condition;
		private String category;

		private double latitude;
		private double longitude;
		private int distance;

		// 정렬에 필요한 데이터를 변수로 선언
		private String order;
		
		public PageVO() {
			this.pageNum = 1;
			this.countPerPage = 20;
			this.latitude = 0.0;
			this.longitude = 0.0;
			this.distance = 15000;
			this.order = "date";
		}
}
