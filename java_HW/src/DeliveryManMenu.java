import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Scanner;

public class DeliveryManMenu {
    int dnum = 0;

    public DeliveryManMenu() {
        Scanner sc = new Scanner(System.in);
        String id;
        int passwd;
        boolean checkResult;

        System.out.println("");
        System.out.println("아이디를 입력하세요");
        id = sc.nextLine();

        System.out.println("");
        System.out.println("비밀번호를 입력하세요");
        passwd = sc.nextInt();

        checkResult = checking(id, passwd);

        if(checkResult == false) {
            return;
        } else{
            while(true) {
                System.out.println("");
                System.out.println("원하는 기능을 선택해주세요");
                System.out.println("");
                System.out.println("1) 배달 주문 선택");
                System.out.println("2) 내 배달 보기");
                System.out.println("3) 끝내기");

                int answer = sc.nextInt();
                switch(answer) {
                    case 1:
                        new chooseOrder(dnum);
                        break;
                    case 2:
                        new MyDeliveryOrders(dnum);
                        break;
                    case 3:
                        return;
                    default:
                        System.out.println("번호를 다시 한 번 확인해주세요.");
                }
            }
        }
    }

    //로그인 확인
    public boolean checking(String id, int passwd) {
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

        //3단계 : id 검색해보기
        try{
            str = conn.createStatement();
            String query = "select dnum from deliveryMan where id = \"" + id + "\"";
            rs = str.executeQuery(query);


            while(rs.next()) {
                dnum = Integer.parseInt(rs.getString("dnum"));
            }

            if(dnum == 0) {
                System.out.println("id가 맞지 않습니다.");
                System.out.println("");
                return false;
            }

            rs.close();
            str.close();
            conn.close();
        } catch(Exception e) {
            System.out.println("검색에 실패했습니다.");
            System.out.println(e);
            return false;
        }

        //4단계 : 비번 체크
        if(passwd != 1234) {
            System.out.println("비밀번호가 맞지 않습니다.");
            return false;
        }

        return true;
    }
}
