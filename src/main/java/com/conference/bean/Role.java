package com.conference.bean;

import java.util.Objects;

public final class Role {
    private final int role_id;
    private final boolean asListener;
    private final boolean asSpeaker;
    private final boolean asModerator;
    private final String name;

    private static Role MODER;
    private static Role SPEAKER;
    private static Role LISTENER;

    static {
        try {
            MODER = new Role(1);
            SPEAKER = new Role(2);
            LISTENER = new Role(3);
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        }
    }

    public static Role getInstance(int role_id){
        switch (role_id){
            case 1:return MODER;
            case 2:return SPEAKER;
            case 3:return LISTENER;
            default:return null;
        }
    }

    private Role(int role_id) throws IllegalAccessException {
        this.role_id = role_id;
        switch (role_id){
            case 1:
                this.name = "Moderator";
                this.asListener = true;
                this.asSpeaker = true;
                this.asModerator = true;
                break;
            case 2:
                this.name = "Speaker";
                this.asListener = true;
                this.asSpeaker = true;
                this.asModerator = false;
                break;
            case 3:
                this.name = "Listener";
                this.asListener = true;
                this.asSpeaker = false;
                this.asModerator = false;
                break;
            default: throw new IllegalArgumentException();
        }
    }

    public int getRoleID() {
        return role_id;
    }

    public boolean isAsListener() {
        return asListener;
    }

    public boolean isAsSpeaker() {
        return asSpeaker;
    }

    public boolean isAsModerator() {
        return asModerator;
    }

    public String getName() {
        return name;
    }

    @Override
    public String toString() {
        return name;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Role)) return false;
        return name.equals(((Role) o).name);
    }

    @Override
    public int hashCode() {
        return Objects.hash(role_id);
    }
}
