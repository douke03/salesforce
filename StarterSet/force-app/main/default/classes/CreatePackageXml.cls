/*
 * A class that enumerates auxiliary code for creating package.xml.
 * @author Nakano Shoki
 */
@isTest
public class CreatePackageXml {
    /**
     * Generate a member for the report.
     * @author Nakano Shoki
     */
    @isTest
    static void report() {
        List<Report> reportList = [
            SELECT FolderName,
                   DeveloperName
            FROM   Report
            ORDER BY FolderName, DeveloperName
        ];
        String packageXml = '\r\n';
        packageXml = packageXml + '    <types>\r\n';
        for(Report rep : reportList) {
            packageXml = packageXml + '        <members>' + rep.FolderName + '/' + rep.DeveloperName + '</members>' + '\r\n';
        }
        packageXml = packageXml + '        <name>Report</name>\r\n';
        packageXml = packageXml + '    </types>\r\n';
        System.debug(packageXml);
    }
}