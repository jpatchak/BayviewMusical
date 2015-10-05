using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel;
namespace BayviewMusical.Models
{
    public class StudentSignUpModel
    {
        [Required]
        [DisplayName("Code")]
        public string code { get; set; }
        
    }
    public class StudentConfirmationModel
    {
        public string ConfirmationMessage { get; set; }
        public string Code { get; set; }
        public string AuditionDate { get; set; }
        public string AuditionGroup { get; set; }
    }
    public class StudentMyInfoModel
    {
        [Required]
        [DisplayName("First Name")]
        public string FirstName { get; set; }

        [Required]
        [DisplayName("Last Name")]
        public string LastName { get; set; }

        [Required]
        [DisplayName("Email")]
        public string Email { get; set; }

        [Required]
        [DisplayName("Gender")]
        public string Gender { get; set; }

        [Required]
        [DisplayName("Grade")]
        public string Grade { get; set; }

        [Required]
        [DisplayName("Role Auditioning For")]
        public int[] DesiredRoles { get; set; }

        public string Code { get; set; }
    }
    public class StudentMyTimeModel
    {
        public string Code { get; set; }
        public string InfoMessage { get; set; }
        public bool HasTime { get; set; }
        public List<MusicalDate> MusicalDates { get; set; }

        public StudentMyTimeModel(string code)
        {
            
            this.Code = code;
            this.MusicalDates = new List<MusicalDate>();
            int thisMusicalID = Musical.CurrentMusical().musicalID;

            int studentID = new Student(code, thisMusicalID).studentID;

            StudentTime existingTime = new StudentTime(studentID, thisMusicalID);

            if (existingTime.timeID != 0)
            {
                DateTime myDate = existingTime.Date();

                string dateSuffix = (myDate.Day % 10 == 1 && myDate.Day != 11) ? "st"
                : (myDate.Day % 10 == 2 && myDate.Day != 12) ? "nd"
                : (myDate.Day % 10 == 3 && myDate.Day != 13) ? "rd"
                : "th";

                string AuditionDate = existingTime.Date().ToString("dddd, MMMM d") + dateSuffix;
                string AuditionGroup = existingTime.TimeName();

                this.HasTime = true;

                this.InfoMessage = "You have already signed up for <strong>" + AuditionGroup + "</strong> on <strong>" + AuditionDate + "</strong>. Click \"Sign Up\" on another time to change your audition group.";
            }
            else
            {
                this.HasTime = false;
            }

            foreach (MusicalDate md in MusicalDate.AllDates(thisMusicalID))
            {
                foreach (TimeSlot ts in md.TimeSlots)
                {
                    if (ts.ID == existingTime.timeID)
                    {
                        ts.Status = "Mine";
                    }
                }
                this.MusicalDates.Add(md);
            }

        }
    }
    
    public class MusicalDate
    {
        public DateTime Date { get; set; }
        public string DateDisplay { get; set; }
        public int DateID { get; set; }
        public List<TimeSlot> TimeSlots { get; set; }

        public static List<MusicalDate> AllDates(int musicalID)
        {
            List<MusicalDate> returnValue = new List<MusicalDate>();
            foreach (AuditionDate ad in AuditionDate.MusicalDates(musicalID))
            {
                MusicalDate md = new MusicalDate();
                md.Date = (DateTime)ad.date;
                md.DateDisplay = md.Date.ToString("dddd, MMMM d");
                md.DateDisplay += (md.Date.Day % 10 == 1 && md.Date.Day != 11) ? "st"
                                : (md.Date.Day % 10 == 2 && md.Date.Day != 12) ? "nd"
                                : (md.Date.Day % 10 == 3 && md.Date.Day != 13) ? "rd"
                                : "th";
                md.DateID = ad.dateID;
                md.TimeSlots = TimeSlot.AllTimeSlots(md.DateID);
                returnValue.Add(md);
            }
            return returnValue;
        }
    }
    public class TimeSlot
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public string Message { get; set; }
        public string Status { get; set; }
        
        public static List<TimeSlot> AllTimeSlots(int dateID)
        {
            List<TimeSlot> returnValue = new List<TimeSlot>();

            foreach (AuditionTime at in AuditionTime.TimeSlots(dateID))
            {
                TimeSlot ts = new TimeSlot();
                ts.ID = at.timeID;
                ts.Name = at.timeDescription;
                
                //get existing count
                int signedUpCount = at.SignedUpCount();
                if (signedUpCount == at.availableSlots)
                {
                    ts.Message = "Full (" + at.availableSlots.ToString() + ")";
                    ts.Status = "Full";
                }
                else
                {
                    ts.Message = (at.availableSlots - signedUpCount).ToString() + " of " + at.availableSlots.ToString() + " Remaining";
                    ts.Status = "Active";
                }

                if (DateTime.Today.Date < at.signupStartDate || DateTime.Today.Date > at.signupEndDate)
                {
                    ts.Status = "Inactive";
                }

                returnValue.Add(ts);
            }

            return returnValue;
        }

    }
    public class RoleCheckbox
    {
        public int RoleID { get; set; }
        public string RoleName { get; set; }
        public bool IsChecked { get; set; }
    }
    public class DesiredRolesViewModel
    {
        [DisplayName("Role Auditioning For")]
        public RoleCheckbox[] DesiredRoles { get; set; }
    }
    public class AdminLoginViewModel
    {
        [Required]
        [DisplayName("Username")]
        public string UserName { get; set; }

        [Required]
        [DisplayName("Password")]
        public string Password { get; set; }
    }
    public class AdminHomeViewModel
    {
        public int MusicalID { get; set; }
        
        [Required]
        [DisplayName("Musical Name")]
        public string MusicalName { get; set; }

        [Required]
        [DataType(DataType.Date)]
        [DisplayName("Sign Up Start Date")]
        public string SignUpStartDate { get; set; }

        [Required]
        [DataType(DataType.Date)]
        [DisplayName("Sign Up End Date")]
        public string SignUpEndDate { get; set; }

        [Required]
        [DisplayName("Expired Message")]
        public string ExpiredMessage { get; set; }

        [Required]
        [DisplayName("Confirmation Message")]
        public string ConfirmationMessage { get; set; }

    }

    public class AdminEditstudentViewModel
    {
        public int MusicalID { get; set; }
        public int StudentID { get; set; }

        [Required]
        [DisplayName("Code")]
        public string Code { get; set; }

        [Required]
        [DisplayName("First Name")]
        public string FirstName { get; set; }

        [Required]
        [DisplayName("Last Name")]
        public string LastName { get; set; }

        [Required]
        [DisplayName("Email")]
        public string Email { get; set; }

        [Required]
        [DisplayName("Gender")]
        public string Gender { get; set; }

        [Required]
        [DisplayName("Grade")]
        public string Grade { get; set; }

        [Required]
        [DisplayName("Role Auditioning For")]
        public int RoleID { get; set; }

        [Required]
        [DisplayName("Audition Group")]
        public int TimeID { get; set; }

        [Required]
        [DisplayName("Audition Date")]
        public int DateID { get; set; }

        public List<SelectListItem> GenderList { get; set; }
        public List<SelectListItem> GradeList { get; set; }
        public IEnumerable<SelectListItem> DateList { get; set; }
        public IEnumerable<SelectListItem> TimeList { get; set; }
        public IEnumerable<SelectListItem> RoleList { get; set; }

        public AdminEditstudentViewModel()
        {
            this.GenderList = new List<SelectListItem>();
            this.GenderList.Add(new SelectListItem() { Text = "Male", Value = "M" });
            this.GenderList.Add(new SelectListItem() { Text = "Female", Value = "F" });

            this.GradeList = new List<SelectListItem>();
            this.GradeList.Add(new SelectListItem() { Text = "7th", Value = "7" });
            this.GradeList.Add(new SelectListItem() { Text = "8th", Value = "8" });

        }
    }
    public class AdminEditAuditionTime
    {
        public int DateID { get; set; }
        public int TimeID { get; set; }
        public int MusicalID { get; set; }

        [Required]
        [DisplayName("Audition Group")]
        public string TimeDescription { get; set; }

        [Required]
        [DisplayName("Capacity")]
        public int Capacity { get; set; }

        [Required]
        [DisplayName("Sign Up Start Date")]
        public string SignUpStartDate { get; set; }
        
        [Required]
        [DisplayName("Sign Up End Date")]
        public string SignUpEndDate { get; set; }
    }
    public class AdminEditAuditionDate
    {
        public int MusicalID { get; set; }
        public int DateID { get; set; }

        [Required]
        [DisplayName("Date")]
        public string Date { get; set; }
    }

    public class AdminEditMusicalRole
    {
        public int MusicalID { get; set; }
        public int RoleID { get; set; }

        [Required]
        [DisplayName("Role Name")]
        public string RoleName { get; set; }
        
        [Required]
        [DisplayName("Gender")]
        public string Gender { get; set; }
        
        [Required]
        [DisplayName("Grade")]
        public string Grade { get; set; }

        public List<SelectListItem> GenderList { get; set; }
        public List<SelectListItem> GradeList { get; set; }


        public AdminEditMusicalRole()
        {
            this.GenderList = new List<SelectListItem>();
            this.GenderList.Add(new SelectListItem() { Text = "All", Value = "A" });
            this.GenderList.Add(new SelectListItem() { Text = "Male", Value = "M" });
            this.GenderList.Add(new SelectListItem() { Text = "Female", Value = "F" });

            this.GradeList = new List<SelectListItem>();
            this.GradeList.Add(new SelectListItem() { Text = "All", Value = "A" });
            this.GradeList.Add(new SelectListItem() { Text = "7th", Value = "7" });
            this.GradeList.Add(new SelectListItem() { Text = "8th", Value = "8" });

        }

    }
    public class AdminMyAccount
    {
        public int AccountID { get; set; }
        public int MusicalID { get; set; }
        [Required]
        [DisplayName("Username")]
        public string UserName { get; set; }

        [Required]
        [DisplayName("Password")]
        public string Password { get; set; }

        [Required]
        [DisplayName("Retype Password")]
        public string RetypePassword { get; set; }
    }
    public class AdminDatesViewModel
    {
        public int MusicalID { get; set; }
        public List<MusicalDate> MusicalDates { get; set; }
        public AdminDatesViewModel(int musicalID)
        {
            this.MusicalID = musicalID;
            this.MusicalDates = MusicalDate.AllDates(musicalID);
        }
    }
    public class AdminRolesViewModel
    {
        public int MusicalID { get; set; }
        public List<AdminRoleTableRow> Roles { get; set; }
        public AdminRolesViewModel(int musicalID)
        {
            this.MusicalID = musicalID;
            this.Roles = AdminRoleTableRow.AllRows(musicalID);
        }
    }
    public class AdminRoleTableRow
    {
        public string Name { get; set; }
        public int ID { get; set; }
        public string GenderName { get; set; }
        public string GradeLevelName { get; set; }

        public static List<AdminRoleTableRow> AllRows(int musicalID)
        {
            List<AdminRoleTableRow> returnValue = new List<AdminRoleTableRow>();

            foreach(MusicalRole mr in MusicalRole.AllRoles(musicalID))
            {
                AdminRoleTableRow tr = new AdminRoleTableRow();
                tr.Name = mr.name;
                tr.ID = mr.roleID;
                tr.GenderName = mr.gender == "M" ? "Male" : mr.gender == "F" ? "Female" : mr.gender == "A" ? "All" : "";
                tr.GradeLevelName = mr.grade == "7" ? "7th" : mr.grade == "8" ? "8th" : mr.grade == "A" ? "All" : "";
                returnValue.Add(tr);
            }
            return returnValue;
        }
    }
    public class AdminStudentViewModel
    {
        public int MusicalID { get; set; }
    }
    public class AdminTopNavigationViewModel
    {
        public Musical Musical { get; set; }
        public List<Musical> AllMusicals { get; set; }
    }
    public class AdminStudentSearchViewModel
    {
        public List<StudentSearchResult> SearchResults { get; set; }
    }
    public class StudentSearchResult
    {
        public int musicalID { get; set; }
        public int studentID { get; set; }
        public string firstName { get; set; }
        public string lastName { get; set; }
        public string code { get; set; }
        public string gender { get; set; }
        public string grade { get; set; }
        public string email { get; set; }
        public string roleName { get; set; }
        public string dateName { get; set; }
        public string timeName { get; set; }

        public static List<StudentSearchResult> StudentSearchResults(int musicalID, string firstName, string lastName, string code, string gender, string grade, int roleId, int dateID, int timeID)
        {
            List<StudentSearchResult> returnValue = new List<StudentSearchResult>();
            using (BayviewMusicalContext db = new BayviewMusicalContext())
            {
                var results = (from stu in db.Students
                               join sr in db.StudentRoles on stu.studentID equals sr.studentID into ljsr
                               from subsr in ljsr.DefaultIfEmpty()
                               join role in db.MusicalRoles on subsr.roleID equals role.roleID into ljrole
                               from subrole in ljrole.DefaultIfEmpty()
                               join time in db.StudentTimes on stu.studentID equals time.studentID into ljtime
                               from subtime in ljtime.DefaultIfEmpty()
                               join at in db.AuditionTimes on subtime.timeID equals at.timeID into ljat
                               from subat in ljat.DefaultIfEmpty()
                               join date in db.AuditionDates on subat.dateID equals date.dateID into ljdate
                               from subdate in ljdate.DefaultIfEmpty()
                               where (stu.musicalID == musicalID &&
                                        stu.firstName.Contains(firstName) &&
                                        stu.lastName.Contains(lastName) &&
                                        (stu.code == code || code == String.Empty) &&
                                        (stu.gender == gender || gender == "A") &&
                                        (stu.grade == grade || grade == "A") &&
                                        ((subrole.roleID == null ? 0 : subrole.roleID) == roleId || roleId == 0) &&
                                        ((subdate == null ? 0 : subdate.dateID) == dateID || dateID == 0) &&
                                        ((subtime == null ? 0 : subtime.timeID) == timeID || timeID == 0))
                               select new
                               {
                                   musicalID = stu.musicalID,
                                   studentID = stu.studentID,
                                   firstName = stu.firstName,
                                   lastName = stu.lastName,
                                   code = stu.code,
                                   gender = stu.gender == "M" ? "Male" : stu.gender == "F" ? "Female" : "",
                                   grade = stu.grade == "7" ? "7th" : stu.grade == "8" ? "8th" : "",
                                   email = stu.email,
                                   roleName = subrole.name == null ? String.Empty : subrole.name,
                                   dateName = subdate == null ? null : subdate.date,
                                   timeName = subat == null ? String.Empty : subat.timeDescription
                               }).OrderBy(s => s.lastName).ThenBy(s => s.firstName);
                //var sql = ((System.Data.Objects.ObjectQuery)results).ToTraceString();
                foreach (var result in results.ToList())
                {
                    StudentSearchResult sr = new StudentSearchResult()
                    {
                        musicalID = result.musicalID,
                        studentID = result.studentID,
                        firstName = result.firstName,
                        lastName = result.lastName,
                        code = result.code,
                        gender = result.gender,
                        grade = result.grade,
                        email = result.email,
                        roleName = result.roleName,
                        dateName = result.dateName==null ? string.Empty : ((DateTime)result.dateName).ToString("MM/dd/yyyy"),
                        timeName = result.timeName
                    };
                    returnValue.Add(sr);
                }
            }

            return returnValue;
        }
    }
}