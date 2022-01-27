package com.conference.bean;

import java.util.Objects;

public final class Role {
    private int role_id;
    private final boolean asListener;
    private final boolean asSpeaker;
    private final boolean asModerator;
    public final String name;

    private static Role MODER;
    private static Role SPEAKER;
    private static Role LISTENER;

    public static Role getInstance(int role_id){
        switch (role_id){
            case 1: if (MODER == null){
                        MODER = new Role(false,false,true, "Moder");
                        MODER.setRoleID(role_id);
                    }return MODER;
            case 2: if (SPEAKER == null){
                        SPEAKER = new Role(true,true,false, "Speaker");
                        SPEAKER.setRoleID(role_id);
                    }return SPEAKER;
            case 3: if (LISTENER == null){
                        LISTENER = new Role(true,false,false, "Listener");
                        LISTENER.setRoleID(role_id);
                    }return LISTENER;
            default:return null;
        }
    }

    private Role(boolean asListener, boolean asSpeaker, boolean asModerator, String name) {
        this.asListener = asListener;
        this.asSpeaker = asSpeaker;
        this.asModerator = asModerator;
        this.name = name;
    }

    public int getRoleID() {
        return role_id;
    }

    public void setRoleID(int i){
        this.role_id = i;
    }

    public boolean isListener() {
        return asListener;
    }

    public boolean isSpeaker() {
        return asSpeaker;
    }

    public boolean isModerator() {
        return asModerator;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Role)) return false;
        return role_id == ((Role) o).role_id;
    }

    @Override
    public int hashCode() {
        return Objects.hash(role_id);
    }

    @Override
    public String toString() {
        return name;
    }
}
