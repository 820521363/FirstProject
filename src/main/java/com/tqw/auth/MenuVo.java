package com.tqw.auth;

public class MenuVo {
    String menu;
    String path;

    public MenuVo(String menu, String path) {
        this.menu = menu;
        this.path = path;
    }

    public String getMenu() {
        return menu;
    }

    public void setMenu(String menu) {
        this.menu = menu;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }
}
