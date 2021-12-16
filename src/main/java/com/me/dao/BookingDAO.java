package com.me.dao;

import com.me.pojo.Booking;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.query.Query;

/**
 *
 * @author Jaeline
 */
public class BookingDAO extends DAO {

    public void createBooking(Booking booking) {
        try {
            begin();
            getSession().save(booking);
            commit();
        } catch (HibernateException e) {
            System.out.println("failed");
            e.printStackTrace();
            rollback();
        }
    }

    public List<Booking> getUserBookings(long customerid) {
        try {
            begin();
            List<Booking> bookings = new ArrayList<Booking>();
            Query q = getSession().createQuery("from Booking where customerid= :customerid");
            q.setParameter("customerid", customerid);
            bookings = q.getResultList();
            commit();
            return bookings;

        } catch (HibernateException e) {
            System.out.println("failed");
            e.printStackTrace();
            rollback();
        }
        return null;
    }

    public Booking getEventBooking(long eventid) {
        try {
            begin();
            Query q = getSession().createQuery("from Booking where eventid= :eventid");
            q.setParameter("eventid", eventid);
            Booking booking = (Booking) q.uniqueResult();
            commit();
            return booking;
        } catch (HibernateException e) {
            System.out.println("failed");
            e.printStackTrace();
            rollback();
        }
        return null;
    }

    public List<Booking> getAllBookings() {
        try {
            begin();
            List<Booking> bookings = new ArrayList<Booking>();
            Session session = getSession();
            session.clear();
            CriteriaBuilder cb = session.getCriteriaBuilder();
            CriteriaQuery<Booking> query = cb.createQuery(Booking.class);
            Root<Booking> event = query.from(Booking.class);
            query.select(event);
            Query<Booking> q = session.createQuery(query);
            bookings = q.getResultList();
            commit();
            return bookings;

        } catch (HibernateException e) {
            System.out.println("failed");
            e.printStackTrace();
            rollback();
        }
        return null;
    }

    public Booking getBookingById(long bookingid) {

        try {
            begin();
            getSession().clear();
            Query q = getSession().createQuery("from Booking where bookingid= :bookingid");
            q.setParameter("bookingid", bookingid);
            Booking booking = (Booking) q.uniqueResult();
            commit();
            close();
            return booking;
        } catch (HibernateException e) {
            System.out.println("failed");
            e.printStackTrace();
            rollback();
        }
        return null;
    }
    
    public void deleteBooking(long bookingid) {
        try {
            begin();
            Booking booking = getSession().get(Booking.class, bookingid);
            getSession().delete(booking);
            commit();
            close();
        } catch (Exception e) {
            System.out.println("failed");
            e.printStackTrace();
            rollback();
        }
    }
}
