package keyosk;

import java.util.Date;

public class search {
    String did = "";
    String passwd = "";
    String query = "";
    Date date;
    String orderLocation = "";

    public void setDid(String did) {
        this.did = did;
    }

    public void setPasswd(String passwd) {
        this.passwd = passwd;
    }

    public void setQuery(String query) {
        this.query = query;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public void setOrderLocation(String orderLocation) {
        this.orderLocation = orderLocation;
    }


    public String getDid() {
        return did;
    }

    public String getPasswd() {
        return passwd;
    }

    public String getQuery(){
        return query;
    }

    public Date getDate(){
        return date;
    }

    public String getOrderLocation(){
        return orderLocation;
    }

}
