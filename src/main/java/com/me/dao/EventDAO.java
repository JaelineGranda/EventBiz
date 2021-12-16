package com.me.dao;

import com.me.pojo.Event;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.query.Query;

/**
 *
 * @author Jaeline
 */
public class EventDAO extends DAO {

    public void createEvent(Event event) {
        try {
            begin();
            getSession().save(event);
            commit();
        } catch (HibernateException e) {
            System.out.println("failed");
            e.printStackTrace();
            rollback();
        }
    }

    public List<Event> getAllEvents() {
        try {
            begin();
            List<Event> events = new ArrayList<Event>();
            Session session = getSession();
            session.clear();
            CriteriaBuilder cb = session.getCriteriaBuilder();
            CriteriaQuery<Event> query = cb.createQuery(Event.class);
            Root<Event> event = query.from(Event.class);
            query.select(event);
            Query<Event> q = session.createQuery(query);
            events = q.getResultList();
            commit();
            return events;

        } catch (HibernateException e) {
            System.out.println("failed");
            e.printStackTrace();
            rollback();
        }
        return null;
    }

    public List<Event> getAllEventsByKeyword(String keyword, String region, String type, String payment) {
        try {
            begin();
            List<Event> events = new ArrayList<Event>();
            Session session = getSession();
            CriteriaBuilder cb = session.getCriteriaBuilder();
            CriteriaQuery<Event> query = cb.createQuery(Event.class);
            Root<Event> event = query.from(Event.class);

            int counter = 1;
            int temp = 0;
            if (!keyword.isEmpty()) {
                counter++;
            }
            if (!type.isEmpty()) {
                counter++;
            }
            if (!payment.isEmpty()) {
                counter++;
            }
            Predicate[] predicates = new Predicate[counter];
            predicates[0] = cb.equal(event.get("region"), region);

            if (!keyword.isEmpty()) {
                temp++;
                predicates[temp] = cb.like(event.<String>get("eventname"), "%" + keyword + "%");
            }

            if (!type.isEmpty()) {
                temp++;
                predicates[temp] = cb.equal(event.get("type"), type);
            }

            if (!payment.isEmpty() &&  "free".equals(payment)) {
                temp++;
                Float num = 0.00f;
                predicates[temp] = cb.equal(event.get("price").as(Float.class), num);
            } else if (!payment.isEmpty() && "paid".equals(payment)) {
                temp++;
                Float num = 0.00f;
                predicates[temp] = cb.greaterThan(event.get("price").as(Float.class), num);
            }

            query.select(event).where(predicates);
            Query<Event> q = session.createQuery(query);
            events = q.getResultList();
            commit();
            return events;

        } catch (HibernateException e) {
            System.out.println("failed");
            e.printStackTrace();
            rollback();
        }
        return null;
    }

    public Event getEventById(long eventid) {

        try {
            begin();
            getSession().clear();
            Query q = getSession().createQuery("from Event where eventid= :eventid");
            q.setParameter("eventid", eventid);
            Event event = (Event) q.uniqueResult();
            commit();
            close();
            return event;
        } catch (HibernateException e) {
            System.out.println("failed");
            e.printStackTrace();
            rollback();
        }
        return null;
    }

    public List<Event> getEventsByCreatorId(long creatorid) {

        try {
            begin();
            List<Event> events = new ArrayList<Event>();
            getSession().clear();
            Query q = getSession().createQuery("from Event where creatorid= :creatorid");
            q.setParameter("creatorid", creatorid);
            events = q.getResultList();
            commit();
            close();
            return events;

        } catch (HibernateException e) {
            System.out.println("failed");
            e.printStackTrace();
            rollback();
        }
        return null;
    }

    public void updateEvent(Event event) {
        try {
            begin();
            getSession().merge(event);
            commit();
            close();
            System.out.println("updated in the DB");
        } catch (HibernateException e) {
            System.out.println("failed");
            e.printStackTrace();
            rollback();
        }
    }

    public void deleteEvent(long eventid) {
        try {
            begin();
            Event event = getSession().get(Event.class, eventid);
            getSession().delete(event);
            commit();
            close();
        } catch (HibernateException e) {
            System.out.println("failed");
            e.printStackTrace();
            rollback();
        }
    }

    public List<Event> getRecentEvents() {
        try {
            begin();
            List<Event> events = new ArrayList<Event>();
            getSession().clear();
            Query q = getSession().createQuery("from Event order by eventid desc").setMaxResults(3);
            events = q.getResultList();
            commit();
            close();
            return events;

        } catch (HibernateException e) {
            System.out.println("failed");
            e.printStackTrace();
            rollback();
        }
        return null;
    }

    public List<Event> getFreeEvents() {
        try {
            begin();
            List<Event> events = new ArrayList<Event>();
            getSession().clear();
            Query q = getSession().createQuery("from Event where price = 0");
            events = q.getResultList();
            commit();
            close();
            return events;

        } catch (HibernateException e) {
            System.out.println("failed");
            e.printStackTrace();
            rollback();
        }
        return null;
    }

}
