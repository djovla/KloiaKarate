package ClassKiola;
import static org.junit.jupiter.api.Assertions.assertEquals;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.junit.jupiter.api.Test;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import com.intuit.karate.junit5.Karate;

import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;

public class TestRunner {
	
	@Test
    public void testParallel() {
        Results results = Runner.path("classpath:ClassKiola")
                .outputCucumberJson(true)
                .karateEnv("ClassKiola")
                .parallel(5);
        generateReport(results.getReportDir());
        assertEquals(0,results.getFailCount(), results.getErrorMessages());
        
    }

    public static void generateReport(String karateOutputPath) {
        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] {"json"}, true);
        List<String> jsonPaths = new ArrayList<>(jsonFiles.size());
        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
        Configuration config = new Configuration(new File("target"), "Learn Karate");
        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();
    }
	/*
	 * @Karate.Test Karate testRun() { return
	 * Karate.run("Caller","Caller2","idTableGet","petPost","ReadJsonFile").
	 * relativeTo(getClass()); }
	 */
	/*
	 * @Test void testParallel() { Results results =
	 * Runner.path("classpath:ClassKiola").parallel(5); assertEquals(0,
	 * results.getFailCount(), results.getErrorMessages());
	 * generateReport(results.getReportDir());
	 * 
	 * } public static void generateReport(String karateOutputPath) {
	 * Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath),
	 * new String[] {"json"}, true); List<String> jsonPaths = new
	 * ArrayList<>(jsonFiles.size()); jsonFiles.forEach(file ->
	 * jsonPaths.add(file.getAbsolutePath())); Configuration config = new
	 * Configuration(new File("target"), "demo"); ReportBuilder reportBuilder = new
	 * ReportBuilder(jsonPaths, config); reportBuilder.generateReports(); }
	 */
}
