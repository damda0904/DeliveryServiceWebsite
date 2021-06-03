import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Scanner;

public class chooseOrder {
    Connection conn = null;
    Statement str = null;
    String location = null;


    public chooseOrder(int dnum) {
        Scanner sc = new Scanner(System.in);
        int onum = 0;

        getInfo(dnum);

        fetchOrders(location);

        System.out.println("");
        System.out.println("배달할 주문 번호를 선택해주세요");
        onum = sc.nextInt();

        chooseOne(dnum, onum);
    }


    //배달원 정보 가져오기
    public void getInfo(int dnum) {
        ResultSet rs = null;

        //1단계
        try {
            Class.forName("com.mysql.jdbc.Driver");
            System.out.println("");
        } catch (Exception e) {
            System.out.println("MySQL JDBC Driver 로딩을 실패하였습니다.");
            System.out.println("");
            System.out.println(e);
        }

        //2단계
        try{
            String URL = "jdbc:mysql://localhost:3305/homework?serverTimezone=UTC";
            conn = DriverManager.getConnection(URL, "root", "123456");
        } catch(Exception e) {
            System.out.println("DB 서버 접속을 실패하였습니다.");
            System.out.println("");
            System.out.println(e);
        }

        //3단계 : 배달원 정보 가져오기
        try{
            str = conn.createStatement();
            rs = str.executeQuery("select location from deliveryman where dnum = " + dnum);
            while(rs.next()) {
                location = rs.getString("location");
            }
            System.out.println("location : " + location);

        } catch(Exception e) {
            System.out.println("배달원 데이터를 가져오지 못했습니다.");
            System.out.println(e);
        }
    }


    //배달원이 정해지지 않은 모든 주문들을 가져온다
    public void fetchOrders(String location) {
        ResultSet rs = null;

        String rname, fname, onum, price, count;

        //3단계
        try {
            str = conn.createStatement();

            String query = "select o.onum, r.name, f.name, o.price, o.count " +
                    "from orders o, restaurant r, food f " +
                    "where o.rnum = r.rnum " +
                    "and o.fnum = f.fnum " +
                    "and o.dnum = 1 " +
                    "and o.location = \"" + location + "\"";

            rs = str.executeQuery(query);
            System.out.println("주문번호 | 가게명 | 메뉴명 | 주문 수량 | 결제금액");
            System.out.println("-------------------------------------------");
            while(rs.next()) {
                onum = rs.getString("o.onum");
                rname = rs.getString("r.name");
                fname = rs.getString("f.name");
                count = rs.getString("o.count");
                price = rs.getString("o.price");
                System.out.println(onum + " | " + rname + " | " + fname + " | " + count + " | " + price);
            }
            System.out.println("-------------------------------------------");
        } catch(Exception e) {
            System.out.println("주문 리스트를 가져오지 못했습니다.");
            System.out.println(e);
        }
    }

    //배달할 주문 선택
    public void chooseOne (int dnum, int onum) {
        try{
            String query = "update orders set dnum = " + dnum + " where onum = " + onum;

            int rs = str.executeUpdate(query);

            if(rs > 0) {
                System.out.println("주문선택이 완료되었습니다.");
            } else {
                System.out.println("주문 선택에 실패했습니다.");
                return;
            }

            str.close();
            conn.close();
        } catch(Exception e) {
            System.out.println("업데이트에 실패했습니다.");
            System.out.println(e);
        }
    }
}
