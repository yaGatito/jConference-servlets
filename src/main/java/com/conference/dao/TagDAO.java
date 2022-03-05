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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
     * Retrieves all existing key(tag) = value(map of locale = translation)
     *
     * @param c Connection
     * @return Map
     */
    public Map<Tag, Map<String,String>> selectAllTagTranslations(Connection c) {
        try (PreparedStatement ps = c.prepareStatement(
                "SELECT id,name FROM tags");
             PreparedStatement loc = c.prepareStatement(
                     "SELECT lang, name FROM tags_local WHERE id = ?")
        ) {
            Map<Tag, Map<String,String>> tags = new HashMap<>();
            ResultSet set = ps.executeQuery();
            while (set.next()) {
                Tag tag = new Tag(set.getInt(1), set.getString(2));
                Map<String, String> map = new HashMap<>();
                loc.setInt(1,tag.getId());
                ResultSet set1 = loc.executeQuery();
                while (set1.next()){
                    String lang = set1.getString(1);
                    String name = set1.getString(2);
                    map.put(lang,name);
                }
                tags.put(tag, map);
                set1.close();
            }
            set.close();
            return tags;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Retrieves all existing tags
     *
     * @param c Connection
     * @return collection of tags
     */
    public List<Tag> selectForLocale(Connection c, String locale) {
        try (PreparedStatement ps = c.prepareStatement("SELECT id,name FROM tags_local WHERE lang = ?")) {
            ps.setString(1, locale);
            ResultSet set = ps.executeQuery();
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
     * @param c     Connection
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
     * @param c       Connection
     * @param tagName name of tag
     * @return collection with only one tag
     */
    public Tag select(Connection c, String tagName) {
        try (PreparedStatement ps = c.prepareStatement("SELECT id FROM tags WHERE name = ?")) {
            ps.setString(1, tagName);
            ResultSet set = ps.executeQuery();
            set.next();
            Tag tag = new Tag(set.getInt(1), tagName);
            set.close();
            return tag;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Retrieves all tags according to event in specialized locale
     *
     * @param c     connection
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
                tagsStmt.setString(2, locale);

                ResultSet set1 = tagsStmt.executeQuery();
                String name = null;
                while (set1.next()) {
                    name = set1.getString(1);
                }
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
     *
     * @param c   Connection
     * @param map Map of tags where key is locale and value is translate of tag
     * @return true if inserting was successful, false - if not
     */
    public boolean createTag(Connection c, Map<String, String> map) {
        try (PreparedStatement ps = c.prepareStatement(
                "INSERT INTO tags (name) VALUES (?)");
             PreparedStatement getId = c.prepareStatement(
                     "SELECT id FROM tags WHERE name = ?")) {
            c.setAutoCommit(false);
            if (!map.containsKey("en")) {
                return false;
            }

            //Creating base tag
            String enName = map.get("en");
            ps.setString(1, enName);
            ps.executeUpdate();

            //Getting id of just created tag
            getId.setString(1, enName);
            ResultSet set = getId.executeQuery();
            set.next();
            int tagID = set.getInt(1);

            //Adding localizations
            for (Map.Entry<String, String> entry : map.entrySet()) {
                addLocalization(c, tagID, entry.getKey(), entry.getValue());
            }
            c.commit();

            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Create tag method
     *
     * @param c            Connection
     * @param previousName Name of already existing tag that will be changed
     * @param desiredName  Name that you will apply to tag
     * @return true if inserting was successful, false - if not
     */
    public boolean updateTag(Connection c, String previousName, String desiredName) {
        try (PreparedStatement ps = c.prepareStatement("UPDATE tags SET name = ? WHERE name = ?")) {
            ps.setString(1, desiredName);
            ps.setString(2, previousName);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Associating tags with event
     *
     * @param c     Connection
     * @param event Event
     * @param tags  Collection of tag's
     * @return true if operation was success, false - if not
     */
    public boolean associateTagToEvent(Connection c, int event, List<Tag> tags) {
        try (PreparedStatement ps = c.prepareStatement("INSERT INTO tags_from_events (event, tag) VALUES (?,?)")) {
            for (Tag tag : tags) {
                ps.setInt(1, event);
                ps.setInt(2, tag.getId());
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
     *
     * @param c      Connection
     * @param tagId  Id of tag
     * @param locale Locale of tag
     * @param name   Name of tag
     * @return true if inserting was successful, false - if not
     */
    public boolean addLocalization(Connection c, int tagId, String locale, String name) {
        try (PreparedStatement ps = c.prepareStatement("INSERT INTO tags_local (id, lang, name) VALUES (?,?,?)")) {
            ps.setInt(1, tagId);
            ps.setString(2, locale);
            ps.setString(3, name);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Update localization to tag
     *
     * @param c      Connection
     * @param tagId  Id of tag
     * @param locale Locale of tag
     * @param name   Name of tag
     * @return true if inserting was successful, false - if not
     */
    public boolean updateLocalization(Connection c, int tagId, String locale, String name) {
        try (PreparedStatement ps = c.prepareStatement("UPDATE tags_local SET name = ? WHERE id = ? AND lang = ?")) {
            ps.setString(1, name);
            ps.setInt(2, tagId);
            ps.setString(3, locale);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


    public static void main(String[] args) {
        TagDAO tdao = new TagDAO();
        Map<String, String> map = new HashMap<>();
        map.put("en", "Math");
        map.put("ua", "Математика");
        tdao.createTag(DBCPool.getInstance().getConnection(), map);
    }

}
