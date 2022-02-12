package com.conference.util;

public enum SELECT {
    STATUS{
        public String toString() {
            return "WHERE status = ? ORDER BY id";
        }
    }, ID {
        public String toString() { return "WHERE id = ? ORDER BY id"; }
    }, SPEAKER {
        public String toString() {
            return "WHERE speaker = ? ORDER BY id";
        }
    },
    LIMIT_STATUS_ORDERED_ID{
        @Override
        public String toString() {
            return "WHERE speaker = ? LIMIT = ? OFFSET = ? ORDER BY id";
        }
    };
    public abstract String toString();
}

