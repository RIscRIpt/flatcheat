macro Setup2D {
	;Save projection and model view matrices
	invoke glGetFloatv, GL_PROJECTION_MATRIX, srm_ProjectionMatrix
	invoke glGetFloatv, GL_MODELVIEW_MATRIX, srm_ModelViewMatrix

	;Setup 2D projection
	invoke glMatrixMode, GL_PROJECTION
	invoke glLoadIdentity

	sub esp, 4 * 8
	mov_dbl_const esp, 0.0
	fild [screenInfo.iHeight]
	fild [screenInfo.iWidth]
	fstp qword[esp + 8]
	fstp qword[esp + 16]
	mov_dbl_const esp + 24, 0.0
	invoke gluOrtho2D
	
	;Reset model view
	invoke glMatrixMode, GL_MODELVIEW
	invoke glLoadIdentity
	invoke glDisable, GL_TEXTURE_2D ;fixes colors
}

macro Setup3D {
	invoke glEnable, GL_TEXTURE_2D ;restore texture
	;Restore projection and model view matrices
	;Assume current matrix is modelview
	invoke glLoadMatrixf, srm_ModelViewMatrix
	invoke glMatrixMode, GL_PROJECTION
	invoke glLoadMatrixf, srm_ProjectionMatrix
	;Assume switching matrix mode is not required
	;invoke glMatrixMode, GL_MODELVIEW
}

proc StudioRenderModel c ;esi must be preserved
	call [StudioModelRender.StudioRenderModel]
	
	virtual at ebp
		.this StudioModelRender_vars_s
	end virtual

	feature ESP_ENABLED
		mov edi, [.this.m_pCurrentEntity]
		virtual at edi
			.entity cl_entity_s
		end virtual
		mov ebx, [.entity.index]
		test ebx, ebx
		jz .end_ESP_ENABLED
			lea eax, [.entity.origin]
			stdcall CalcScreen, eax
			jnc .end_ESP_ENABLED
				Setup2D
				invoke glBegin, GL_TRIANGLE_STRIP
				cmp [.entity.player], 0
				feature ESP_ENTITIES
					if defined ESP_PLAYERS & ESP_PLAYERS
						jne .ESP_PLAYERS
					else
						jne .ee_restore_3d
					end if
					;Entity is not a player
					invoke glColor3ubv, entityColor
					invoke glVertex2iv, screenCoord
					add [screenCoord.x], 3
					add [screenCoord.y], 8
					invoke glVertex2iv, screenCoord
					sub [screenCoord.x], 6
					invoke glVertex2iv, screenCoord				
					jmp .ee_restore_3d
				felse
					if defined ESP_PLAYERS & ESP_PLAYERS
						je .ee_restore_3d ;no need for jump
					else
						err ;Cannot happen
					end if
				endf
				
				feature ESP_PLAYERS
					;Entity is a player				
					imul edx, [.entity.index], sizeof.cs_player_info_s
					add edx, [pCSPlayerInfo]
					virtual at edx
						.cs_player_info cs_player_info_s
					end virtual
					movzx ecx, byte[.cs_player_info.team]
					lea eax, [teamColorArray3UB + ecx]
					invoke glColor3ubv, eax
					sub [screenCoord.x], 4
					sub [screenCoord.y], 4
					invoke glVertex2iv, screenCoord
					add [screenCoord.x], 8
					invoke glVertex2iv, screenCoord
					sub [screenCoord.x], 8
					add [screenCoord.y], 8
					invoke glVertex2iv, screenCoord
					add [screenCoord.x], 8
					invoke glVertex2iv, screenCoord
				endf
				.ee_restore_3d:
				invoke glEnd
				Setup3D
	endf
	ret
endp
