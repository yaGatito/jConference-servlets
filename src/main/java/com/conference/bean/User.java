package com.conference.bean;

public class User {
    private int id;
    private Role role;
    private String name;
    private String lastname;
    private String email;
    private String password;

    public User(int id, int role, String name, String lastname, String email, String password) {
        this.id = id;
        this.role = Role.getInstance(role);
        this.name = name;
        this.lastname = lastname;
        this.email = email;
        this.password = password;
    }

    public User(int role, String name, String lastname, String email, String password) {
        this.role = Role.getInstance(role);
        this.name = name;
        this.lastname = lastname;
        this.email = email;
        this.password = password;
    }

    public void setRole(int role) {
        this.role = Role.getInstance(role);
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getId() {
        return id;
    }

    public int getRoleID() {
        return role.getRoleID();
    }
    public Role getRole() {
        return role;
    }
    public String getName() {
        return name;
    }

    public String getLastname() {
        return lastname;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof User)) return false;
        User user = (User) o;
        return getId() == user.getId();
    }

    @Override
    public int hashCode() {
        return getId();
    }

    @Override
    public String toString() {
        return name + " " +  lastname ;
    }
}
