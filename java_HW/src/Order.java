import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Scanner;

public class Order {
    public Order() {
        Scanner sc = new Scanner(System.in);
        int fnum = 0;
        int count = 0;

        System.out.println("");


        showMenu();

        System.out.println("");
        System.out.println("메뉴번호를 입력하세요");
        System.out.println("");
        fnum = sc.nextInt();

        System.out.println("");
        System.out.println("수량을 입력하세요");
        System.out.println("");

        count = sc.nextInt();

        new OrderResult(fnum, count);
    }

    //모든 메뉴들을 출력
    public void showMenu(){
        Connection conn = null;
        Statement str = null;
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

        String fnum, name, price, place;

        //3단계 : 메뉴 리스트 출력
        try {
            str = conn.createStatement();
            rs = str.executeQuery("select * from food f, restaurant r where f.rnum = r.rnum");
            System.out.println("==================================");
            System.out.println("메뉴 번호 | 메뉴명 | 가격 | 위치");

            while(rs.next()) {
                fnum = rs.getString("f.fnum");
                name = rs.getString("f.name");
                price = rs.getString("f.price");
                place = rs.getString("r.place");
                System.out.println(fnum + " | " + name + " | " + price + " | " + place);
            }
            System.out.println("==================================");

            rs.close();
            str.close();
            conn.close();
        } catch (Exception e) {
            System.out.println("테이블의 전체 데이터 검색을 실패하였습니다.");
            System.out.println(e);
        }

    }
}

