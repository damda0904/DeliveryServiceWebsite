import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Scanner;

public class InsertMenu {
    public InsertMenu(int rnum) {
        String name;
        int price;
        Scanner sc = new Scanner(System.in);

        System.out.println("");
        System.out.println("메뉴 이름을 입력해주세요");
        name = sc.nextLine();

        System.out.println("");
        System.out.println("가격을 입력해주세요");
        price = sc.nextInt();

        insert(rnum, name, price);

    }

    //메뉴 입력
    public void insert(int rnum, String name, int price) {
        Connection conn = null;
        Statement str = null;
        int rs = 0;

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

        //3단계
        try{
            String value = "\"" + name + "\", " + price + ", " + rnum;

            str = conn.createStatement();
            rs = str.executeUpdate("insert into food(name, price, rnum) values (" + value +")");

            if(rs > 0) {
                System.out.println("메뉴를 성공적으로 추가했습니다.");

                str.close();
                conn.close();
            } else {
                System.out.println("메뉴 추가에 실패했습니다.");
            }
        } catch(Exception e) {
            System.out.println("insert에 실패했습니다.");
            System.out.println(e);
        }
    }
}
