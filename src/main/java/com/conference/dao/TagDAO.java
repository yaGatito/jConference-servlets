package com.conference.dao;

import com.conference.DBCPool;
import com.conference.entity.Tag;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TagDAO {
    private static final Logger log = LoggerFactory.getLogger(TagDAO.class);
    /**
     * Retrieves all existing tags
     *
     * @param c Connection
     * @return collection of tags
     */
    public List<Tag> select(Connection c) {
        try (PreparedStatement ps = c.prepareStatement("SELECT id,name FROM tags");
             ResultSet set = ps.executeQuery()) {
            List<Tag> tags = new ArrayList<>();
            while (set.next()) {
                tags.add(new Tag(set.getInt(1), set.getString(2)));
            }
            return tags;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * This overloading method retrieves tag in accordance to requested id
     *
     * @param c  Connection
     * @param tagId id of tag
     * @return collection with only one tag
     */
    public Tag select(Connection c, int tagId) {
        try (PreparedStatement ps = c.prepareStatement("SELECT name FROM tags WHERE id = ?")) {
            ps.setInt(1, tagId);
            ResultSet set = ps.executeQuery();
            set.next();
            Tag tag = new Tag(tagId, set.getString(1));
            set.close();
            return tag;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * This overloading method retrieves tag in accordance to requested name
     *
     * @param c  Connection
     * @param tagName name of tag
     * @return collection with only one tag
     */
    public Tag select(Connection c, String tagName) {
        try (PreparedStatement ps = c.prepareStatement("SELECT id FROM tags WHERE name = ?")) {
            ps.setString(1, tagName);
            ResultSet set = ps.executeQuery();
            set.next();
            Tag tag = new Tag(set.getInt(1),tagName);
            set.close();
            return tag;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Retrieves all tags according to event in specialized locale
     * @param c connection
     * @param event event id
     * @return collection of tags
     */
    public List<Tag> selectForEvents(Connection c, int event, String locale) {
        List<Tag> tags = new ArrayList<>();
        try (PreparedStatement tagIdStmt = c.prepareStatement("SELECT tag FROM tags_from_events WHERE event = ?");
        PreparedStatement tagsStmt = c.prepareStatement("SELECT name FROM tags_local WHERE id = ? AND lang = ?")) {
            tagIdStmt.setInt(1, event);
            ResultSet set = tagIdStmt.executeQuery();
            while (set.next()) {
                int idTag = set.getInt(1);

                tagsStmt.setInt(1, idTag);
                tagsStmt.setString(2,locale);

                ResultSet set1 = tagsStmt.executeQuery();
                set1.next();
                String name = set1.getString(1);
                set1.close();

                tags.add(new Tag(idTag, name));
            }
            set.close();
            return tags;
        } catch (SQLException e) {
            e.printStackTrace();
            return tags;
        }
    }

    /**
     * Create tag method
     * @param c Connection
     * @param name Name of tag
     * @return true if inserting was successful, false - if not
     */
    public boolean createTag(Connection c, String name){
        try(PreparedStatement ps = c.prepareStatement("INSERT INTO tags (name) VALUES (?)")) {
            ps.setString(1,name);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Create tag method
     * @param c Connection
     * @param previousName Name of already existing tag that will be changed
     * @param desiredName Name that you will apply to tag
     * @return true if inserting was successful, false - if not
     */
    public boolean updateTag(Connection c, String previousName, String desiredName){
        try(PreparedStatement ps = c.prepareStatement("UPDATE tags SET name = ? WHERE name = ?")) {
            ps.setString(1,desiredName);
            ps.setString(2,previousName);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Associating tags with event
     * @param c Connection
     * @param event Event
     * @param tagIds Collection of tag's ids
     * @return true if operation was success, false - if not
     */
    public boolean associateTagToEvent(Connection c, int event, List<Integer> tagIds){
        try(PreparedStatement ps = c.prepareStatement("INSERT INTO tags_from_events (event, tag) VALUES (?,?)")) {
            for (Integer id : tagIds) {
                ps.setInt(1,event);
                ps.setInt(2,id);
                ps.executeUpdate();
            }
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Add localization to tag
     * @param c Connection
     * @param tagId Id of tag
     * @param locale Locale of tag
     * @param name Name of tag
     * @return true if inserting was successful, false - if not
     */
    public boolean addLocalization(Connection c, int tagId, String locale, String name){
        try(PreparedStatement ps = c.prepareStatement("INSERT INTO tags_local (id, lang, name) VALUES (?,?,?)")) {
            ps.setInt(1,tagId);
            ps.setString(2,locale);
            ps.setString(3,name);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Update localization to tag
     * @param c Connection
     * @param tagId Id of tag
     * @param locale Locale of tag
     * @param name Name of tag
     * @return true if inserting was successful, false - if not
     */
    public boolean updateLocalization(Connection c, int tagId, String locale, String name){
        try(PreparedStatement ps = c.prepareStatement("UPDATE tags_local SET name = ? WHERE id = ? AND lang = ?")) {
            ps.setString(1,name);
            ps.setInt(2,tagId);
            ps.setString(3,locale);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
