package com.conference.dao;

public enum SELECT {
    STATUS{
        public String toString() {
            return "SELECT * FROM events WHERE status = ?";
        }
    }, ID {
        public String toString() {
            return "SELECT * FROM events WHERE id = ?";
        }
    }, SPEAKER {
        public String toString() {
            return "SELECT * FROM events WHERE speaker = ?";
        }
    };
    public abstract String toString();
}

