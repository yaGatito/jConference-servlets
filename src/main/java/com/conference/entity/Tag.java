package com.conference.entity;

import java.util.Locale;
import java.util.Objects;

public class Tag {
    private final int id;
    private String en;
    private String ru;

    public Tag(int id, String en, String ru) {
        this.id = id;
        this.en = en;
        this.ru = ru;
    }

    public int getId() {
        return id;
    }

    public String getEn() {
        return en;
    }

    public void setEn(String en) {
        this.en = en;
    }

    public String getRu() {
        return ru;
    }

    public void setRu(String ru) {
        this.ru = ru;
    }

    @Override
    public String toString() {
        return "Tag{" +
                "en='" + en + '\'' +
                ", ru='" + ru + '\'' +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Tag)) return false;
        Tag tag = (Tag) o;
        return getId() == tag.getId();
    }

    @Override
    public int hashCode() {
        return getId();
    }

    public static void main(String[] args) {
        Locale locale = Locale.US;
    }
}
