package com.me.dao;

import com.me.pojo.User;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.hibernate.query.Query;

public class UserDAO extends DAO {

    public void createUser(User user) {
        try {
            begin();
            getSession().save(user);
            commit();
        } catch (Exception e) {
            System.out.println("failed");
            e.printStackTrace();
            rollback();
        }
        System.out.println("User saved in the DB");
    }
    
        public List<User> getAllUsers() {
        try {
            begin();
            List<User> users = new ArrayList<User>();
            Session session = getSession();
            session.clear();
            CriteriaBuilder cb = session.getCriteriaBuilder();
            CriteriaQuery<User> query = cb.createQuery(User.class);
            Root<User> user = query.from(User.class);
            query.select(user);
            Query<User> q = session.createQuery(query);
            users = q.getResultList();
            commit();
            return users;

        } catch (HibernateException e) {
            System.out.println("failed");
            e.printStackTrace();
            rollback();
        }
        return null;
    }

    public User loginUser(String username, String password, String role) {
        try {
            begin();
            Query query = getSession().createQuery("from User where username = :username and password = :password and role = :role");
            query.setParameter("username", username);
            query.setParameter("password", password);
            query.setParameter("role", role);
            User user = (User) query.uniqueResult();
            commit();
            return user;
        } catch (HibernateException e) {
            System.out.println("failed");
            e.printStackTrace();
            rollback();
        }
        return null;
    }

    public User get(String username) {
        try {
            begin();
            Query q = getSession().createQuery("from User where username = :username");
            q.setParameter("username", username);
            User user = (User) q.uniqueResult();
            commit();
            return user;
        } catch (HibernateException e) {
            System.out.println("failed");
            e.printStackTrace();
            rollback();
        }
        return null;
    }

    public User getUserById(long userid) {
        try {
            begin();
            getSession().clear();
            Query q = getSession().createQuery("from User where userid= :userid");
            q.setParameter("userid", userid);
            User user = (User) q.uniqueResult();
            commit();
            return user;
        } catch (HibernateException e) {
            System.out.println("failed");
            e.printStackTrace();
            rollback();
        }
        return null;
    }
    
    public void deleteUser(long userid) {
        try {
            begin();
            User user = getSession().get(User.class, userid);
            getSession().delete(user);
            commit();
            close();
        } catch (Exception e) {
            System.out.println("failed");
            e.printStackTrace();
            rollback();
        }
    }

    public void updateUser(User user) {
        try {
        begin();
        getSession().update(user);
        commit();
        close();
        } catch (Exception e) {
            System.out.println("failed");
            e.printStackTrace();
            rollback();
        }
        
    }
    
    public User checkIfUsernameAlreadyExists(User user) {
        try {
            begin();
            Query query = getSession().createQuery("from User where username= :username");
            query.setParameter("username", user.getUsername());
            User user1 = (User) query.uniqueResult();
            commit();
            return user1;
        } catch (HibernateException e) {
            System.out.println("failed");
            e.printStackTrace();
            rollback();
        }
        return null;     
    }

    public User checkIfEmailAlreadyExists(User user) {
        try {
            begin();
            Query query = getSession().createQuery("from User where email= :email");
            query.setParameter("email", user.getEmail());
            User user1 = (User) query.uniqueResult();
            commit();
            return user1;
        } catch (HibernateException e) {
            System.out.println("failed");
            e.printStackTrace();
            rollback();
        }
        return null;        
    }
    
}
