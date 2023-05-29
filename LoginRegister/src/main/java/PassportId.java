
public class PassportId {

	public static int count = 0;
	
	public static synchronized String generateUserID() {
		int uniqueNumber = ++count;
		String formattedNumber = String.format("%04d", uniqueNumber);
		return "PASS" + formattedNumber;
	}
}
