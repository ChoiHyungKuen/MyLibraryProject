package egovframework.example.nav.service.impl;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
@Mapper("navMapper")
public interface NavMapper {

	List<?> selectMainMenu() throws Exception;

}
