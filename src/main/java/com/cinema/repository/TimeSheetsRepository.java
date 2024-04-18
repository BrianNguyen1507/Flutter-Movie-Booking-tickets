package com.cinema.repository;

import com.cinema.entity.TimeSheetsEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.Date;
import java.util.List;

public interface TimeSheetsRepository extends JpaRepository<TimeSheetsEntity,Long> {
    @Query(value="SELECT t FROM TimeSheetsEntity t WHERE t.employee.id = ?1 AND YEAR(t.date) = ?2 AND MONTH (t.date) = ?3 AND DAY (t.date) = ?4")
    TimeSheetsEntity checkDuplicateDate(long id, int year,int month, int day);

    @Query(value="SELECT t FROM TimeSheetsEntity t WHERE YEAR(t.date) = ?1 AND MONTH (t.date) = ?2 AND DAY (t.date) = ?3")
    List<TimeSheetsEntity> findAllByDay( int year,int month, int day);

    @Query(value="SELECT t FROM TimeSheetsEntity t WHERE YEAR(t.date) = ?1 AND MONTH (t.date) = ?2 AND DAY (t.date) = ?3 AND t.status = ?4")
    List<TimeSheetsEntity> findAllByDayAnAndStatus( int year,int month, int day,String status);

    @Query(value="SELECT t FROM TimeSheetsEntity t WHERE YEAR(t.date) = ?1 AND MONTH (t.date) = ?2 AND t.employee.id=?3")
    List<TimeSheetsEntity> finAllByMonthAndYearAndId( int year,int month,long id);

    @Query(value="SELECT t FROM TimeSheetsEntity t WHERE YEAR(t.date) = ?1 AND t.employee.id=?2")
    List<TimeSheetsEntity> finAllByYearAndId( int year,long id);

}
