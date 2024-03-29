package com.cinema.api;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.cinema.dto.FilmDTO;
import com.cinema.dto.ReleaseDateFilm;
import com.cinema.services.impl.FilmService;


@RestController
@RequestMapping("/cinema")
public class FilmAPI {
	
	@Autowired
	private FilmService filmService;
	
	@PostMapping(value = "/listfeatured")
	public List<FilmDTO> showEmployees(@RequestBody ReleaseDateFilm model)
	{
		return filmService.findAllDTOByReleaseDate(model);
	}
	
	@GetMapping(value = "/detailFilm")
	public FilmDTO detailFilm(@RequestParam("id") long id ) {
		return filmService.detailFilm(id);
	}
	
	@PostMapping(value = "/addFilm")
	public FilmDTO saveFilm(@RequestBody FilmDTO filmDTO) {
		return filmService.addFilm(filmDTO);
	}
	
	@PostMapping(value = "/updateFilm")
	public FilmDTO updateFilm(@RequestBody FilmDTO filmDTO) {
		return filmService.updateFilm(filmDTO);
	}
	
	@GetMapping(value = "/deleteFilm")
	public boolean deleteFilm(@RequestParam("id") long id) {
		return filmService.deleteFilm(id);
	}
	
	@GetMapping(value="/showAllFilm")
	public List<FilmDTO> showAllFilm(){
		return filmService.getAllFilm();
	}
}