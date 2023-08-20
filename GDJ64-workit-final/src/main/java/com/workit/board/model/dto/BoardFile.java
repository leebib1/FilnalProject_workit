package com.workit.board.model.dto;

import com.workit.chatroom.model.dto.AttachedFile;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class BoardFile {
	private int boardFileNo;
	private Board board;
	private AttachedFile file;

}
