package com.bts.common.file;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import net.coobird.thumbnailator.Thumbnails;


@Controller
public class FileDownloadController {
	//학원 컴퓨터 git 위치 
	//private static String CURR_IMAGE_REPO_PATH = "C:\\Users\\311\\git\\Ticket\\TicketSite\\src\\main\\webapp\\resources\\shopping\\file_repo";
    //본인 컴퓨터 git 위치 
	private static final String CURR_IMAGE_REPO_PATH = "C:\\Users\\82107\\git\\Ticket\\TicketSite\\src\\main\\webapp\\resources\\shopping\\file_repo";
	//private static String CURR_IMAGE_REPO_PATH = "C:\\bts\\TicketSite\\src\\main\\webapp\\resources\\shopping\\file_repo";
	@RequestMapping("/download")
	protected void download(@RequestParam("fileName") String fileName,
		                 	@RequestParam("goods_id") String goods_id,
			                 HttpServletResponse response) throws Exception {
		OutputStream out = response.getOutputStream();
		String filePath=CURR_IMAGE_REPO_PATH+"\\"+goods_id+"\\"+fileName;
		File image=new File(filePath);

		response.setHeader("Cache-Control","no-cache");
		response.addHeader("Content-disposition", "attachment; fileName="+fileName);
		FileInputStream in=new FileInputStream(image); 
		byte[] buffer=new byte[1024*8];
		while(true){
			int count=in.read(buffer); 
			if(count==-1)  
				break;
			out.write(buffer,0,count);
		}
		in.close();
		out.close();
	}
	
	
	@RequestMapping("/thumbnails.do")
	protected void thumbnails(@RequestParam("fileName") String fileName,
                            	@RequestParam("goods_id") String goods_id,
			                 HttpServletResponse response) throws Exception {
		OutputStream out = response.getOutputStream();
		String filePath=CURR_IMAGE_REPO_PATH+"\\"+goods_id+"\\"+fileName;
		//String filePath="/home/k1/images/"+goods_id+"/"+fileName; 우분투에서 윈도우 데이터 끌어다 쓰는 경우 
		File image=new File(filePath);
		
		if (image.exists())
		{ 
			Thumbnails.of(image).size(121,154).outputFormat("png").toOutputStream(out);
		}
		byte[] buffer = new byte[1024 * 8];
		out.write(buffer);
		out.close();
	}
}
