package com.spring.wefit.commons;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.web.multipart.MultipartFile;

public class CustomFileUpload {
	public List<String> fileUpload(MultipartFile[] fileName, int MaxFileCount, String filePath){
		List<String> list = new ArrayList<>();
		ByteCheck bchk = new ByteCheck();
		
		
		
		int imgCount = 0;
		
		File folder = new File(filePath);
		
		if(!folder.exists()) {
			try {
				folder.mkdirs();
			}catch(Exception e) {}
			
		}
		System.out.println("업로드 안한경우 첫 파일 이름:"+fileName[0].getOriginalFilename());
		for(MultipartFile f : fileName) {
			if(f.isEmpty()) break;
			String originFileName = f.getOriginalFilename(); // 원본 파일 명 + 확장자
			String randomFileName = UUID.randomUUID()
									.toString().split("-")[0] 
									+ originFileName.substring(originFileName.lastIndexOf("."),
									originFileName.length()); // 서버에 저장할 파일명
			if(!bchk.byteCheck(originFileName, 50)) {
				System.out.println("파일명이 너무 깁니다.");
				continue;
			}
			imgCount++;
			if(imgCount > MaxFileCount) {
				System.out.printf("파일은 %d개까지만 가능합니다.\n",MaxFileCount);
				break;
			}
			list.add(originFileName);
			list.add(randomFileName);
			File saveFile = new File(filePath+randomFileName);
			try {
				f.transferTo(saveFile);
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		if(list.size() < MaxFileCount*2) {
			int fillCount = (MaxFileCount*2)-list.size(); // 리스트 요소 늘리기 위한 null값 넣기
			for(int i = 0;i<fillCount;i++) {
				list.add(null);
			}
		}
		
		
		return list;
	}

	public void delete(String fileName, String filePath) {
		File file = new File(filePath+fileName);
		file.delete();
	}
}
