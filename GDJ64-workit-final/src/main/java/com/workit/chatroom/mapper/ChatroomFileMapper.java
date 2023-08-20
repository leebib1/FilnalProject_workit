package com.workit.chatroom.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.workit.chatroom.model.dto.AttachedFile;

@Mapper
public interface ChatroomFileMapper {

	int saveFile(Map<String, Object> param);
	
	int uploadFile(Map<String, Object> param);
	
	AttachedFile selectFileById(String fileId);
}
