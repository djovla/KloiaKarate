package Animals;

import com.intuit.karate.junit5.Karate;

public class NewTest {
  @Karate.Test
  Karate testSample() {
	  return Karate.run("classpath:ClassKiola").relativeTo(getClass());
  }
}
