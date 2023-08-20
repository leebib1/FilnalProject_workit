package com.workit.chatroom.model.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class AttachedFile {
	private String fileId;
	private String originalFile;
	private String uploadFile;
	private String uploadPath;
	private Date uploadDate;
	private String fileStatus;
}
