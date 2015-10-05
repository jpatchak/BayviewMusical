using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BayviewMusical
{
    partial class Musical
    {
        public Musical() { }

        public Musical(int requestedMusicalID)
        {
            using (BayviewMusicalContext db = new BayviewMusicalContext())
            {
                var musicals = (from musical in db.Musicals
                                select musical).Where(m => m.musicalID == requestedMusicalID).FirstOrDefault();
                if (musicals != null)
                {
                    this.musicalID = requestedMusicalID;
                    this.name = musicals.name;
                    this.signupStartDate = musicals.signupStartDate;
                    this.signupEndDate = musicals.signupEndDate;
                    this.expiredMessage = musicals.expiredMessage;
                    this.confirmationMessage = musicals.confirmationMessage;
                }
            }
        }

        public void Save()
        {
            using (BayviewMusicalContext db = new BayviewMusicalContext())
            {
                if (this.musicalID == 0)
                {
                    db.Musicals.AddObject(this);
                    db.SaveChanges();
                    var musicals = (from musical in db.Musicals
                                    select musical).Where(m => m.musicalID == this.musicalID).FirstOrDefault();
                    this.musicalID = musicals.musicalID;
                }
                else
                {
                    var musicals = (from musical in db.Musicals
                                    select musical).Where(m => m.musicalID == this.musicalID).FirstOrDefault();
                    musicals.name = this.name;
                    musicals.signupStartDate = this.signupStartDate;
                    musicals.signupEndDate = this.signupEndDate;
                    musicals.expiredMessage = this.expiredMessage;
                    musicals.confirmationMessage = this.confirmationMessage;
                    db.SaveChanges();
                    this.musicalID = musicals.musicalID;
                }
                
                
            }
        }

        public static List<Musical> AllMusicals()
        {
            List<Musical> returnValue = new List<Musical>();
            using (BayviewMusicalContext db = new BayviewMusicalContext())
            {
                var musicals = (from musical in db.Musicals
                                select musical).OrderBy((m => (m.signupStartDate <= DateTime.Today.Date && m.signupEndDate >= DateTime.Today.Date) ? 0 : 1)).ThenByDescending(m => m.signupStartDate);
                if (musicals != null)
                    returnValue = musicals.ToList();
            }
            return returnValue;
        }

        public static Musical CurrentMusical()
        {
            Musical returnValue = new Musical();
            DateTime currentDate = DateTime.Today.Date;
            using (BayviewMusicalContext db = new BayviewMusicalContext())
            {
                var musicals = (from musical in db.Musicals
                        select musical).OrderBy((m=>(m.signupStartDate<=currentDate && m.signupEndDate>=currentDate)?0:1)).ThenByDescending(m=>m.signupStartDate);
                returnValue = musicals.First();
            }

            return returnValue;
        }
    }
    public class StudentDateTime
    {
        public int DateID { get; set; }
        public int TimeID { get; set; }

        public StudentDateTime(int studentID)
        {
            using (BayviewMusicalContext db = new BayviewMusicalContext())
            {
                var data = (from time in db.StudentTimes
                            join at in db.AuditionTimes on time.timeID equals at.timeID
                            where time.studentID == studentID
                            select new { DateID = at.dateID, TimeID = time.timeID }).FirstOrDefault();
                if (data != null)
                {
                    this.DateID = data.DateID;
                    this.TimeID = data.TimeID;
                }
            }
        }
    }
    partial class Student
    {
        public Student() { }
        public Student(int studentID)
        {
            Student stu;

            using (BayviewMusicalContext db = new BayviewMusicalContext())
            {
                var students = (from student in db.Students
                                select student).Where(s => s.studentID == studentID);
                stu = students.FirstOrDefault();
            }

            if (stu != null)
            {
                this.studentID = stu.studentID;
                this.code = stu.code;
                this.email = stu.email;
                this.firstName = stu.firstName;
                this.lastName = stu.lastName;
                this.gender = stu.gender;
                this.grade = stu.grade;
            }
            else
            {
                this.gender = "M";
                this.grade = "7";
            }
        }
        public Student(string code, int musicalID)
        {
            Student stu;
            
            using (BayviewMusicalContext db = new BayviewMusicalContext())
            {
                var students = (from student in db.Students
                                select student).Where(s => s.code == code && s.musicalID == musicalID);
                stu = students.FirstOrDefault();
            }

            if (stu != null)
            {
                this.studentID = stu.studentID;
                this.code = stu.code;
                this.email = stu.email;
                this.firstName = stu.firstName;
                this.lastName = stu.lastName;
                this.gender = stu.gender;
                this.grade = stu.grade;
            }
            else
            {
                this.gender = "M";
                this.grade = "7";
            }
        }
        public List<int> RoleIDs(int musicalID)
        {
            List<int> returnValue = new List<int>();

            using (BayviewMusicalContext db = new BayviewMusicalContext())
            {
                var ids = db.StudentRoles.Where(s => s.studentID == this.studentID && s.MusicalRole.musicalID == musicalID).Select(s => s.roleID);
                returnValue = ids.ToList();
            }

            return returnValue;
        }
        public void Delete()
        {
            using (BayviewMusicalContext db = new BayviewMusicalContext())
            {
                //delete roles

                //delete times

                //delete student
                Student stu = db.Students.SingleOrDefault(s => s.studentID == this.studentID);
                db.DeleteObject(stu);
                db.SaveChanges();
            }
        }
        public void Save(List<int> DesiredRoles)
        {
            using (BayviewMusicalContext db = new BayviewMusicalContext())
            {
                if (this.studentID == 0)
                {
                    db.Students.AddObject(this);
                }
                else
                {
                    Student stu = db.Students.SingleOrDefault(s => s.studentID == this.studentID);
                    if (stu != null)
                    {
                        stu.firstName = this.firstName;
                        stu.lastName = this.lastName;
                        stu.email = this.email;
                        stu.gender = this.gender;
                        stu.grade = this.grade;
                    }
                }
                db.SaveChanges();

                //Delete roles not in DesiredRoles list

                var roles = db.StudentRoles.Where(s => s.studentID == this.studentID && s.MusicalRole.musicalID == musicalID && !DesiredRoles.Contains(s.roleID));
                foreach (StudentRole r in roles.ToList())
                {
                    db.DeleteObject(r);
                }
                db.SaveChanges();

                //Insert roles not already in database
                var existingRolesForStudent = (from role in db.StudentRoles
                                               join mr in db.MusicalRoles on role.roleID equals mr.roleID
                                               where this.studentID == role.studentID && mr.musicalID == this.musicalID
                                               select role.roleID);
                foreach(int roleID in DesiredRoles.Where(r=> !existingRolesForStudent.ToList().Contains(r)))
                {
                    StudentRole r = new StudentRole();
                    r.roleID = roleID;
                    r.studentID = this.studentID;
                    db.StudentRoles.AddObject(r);
                }
                db.SaveChanges();

            }
        }
    }
    partial class StudentCode
    {
        public bool IsValid()
        {
            bool returnValue;
            using (BayviewMusicalContext db = new BayviewMusicalContext())
            {
                returnValue = db.StudentCodes.Any(c => c.Code == this.Code);
            }
            return returnValue;
        }

        public bool IsClaimed()
        {
            bool returnValue;
            using (BayviewMusicalContext db = new BayviewMusicalContext())
            {
                returnValue = db.Students.Any(c => c.code == this.Code);
            }
            return returnValue;
        }
    }
    partial class MusicalRole
    {
        public MusicalRole() { }
        public MusicalRole(int roleID)
        {
            using (BayviewMusicalContext db = new BayviewMusicalContext())
            {
                var roles = (from role in db.MusicalRoles
                             select role).Where(r => r.roleID == roleID).FirstOrDefault();
                this.roleID = roleID;
                if (roles != null)
                {
                    this.musicalID = roles.musicalID;
                    this.name = roles.name;
                    this.gender = roles.gender;
                    this.grade = roles.grade;
                }
            }

        }
        public static List<MusicalRole> AvailableRoles(int musicalID, string gender, string grade)
        {
            List<MusicalRole> returnValue;

            using (BayviewMusicalContext db = new BayviewMusicalContext())
            {
                var roles = (from role in db.MusicalRoles
                             select role).Where(r => r.musicalID == musicalID && (r.gender == gender || r.gender == "A") && (r.grade == grade || r.grade == "A")).OrderBy(r=>r.name);
                returnValue = roles.ToList();
            }

            return returnValue;
        }
        public static List<MusicalRole> AllRoles(int musicalID)
        {
            List<MusicalRole> returnValue;

            using (BayviewMusicalContext db = new BayviewMusicalContext())
            {
                var roles = (from role in db.MusicalRoles
                             select role).Where(r => r.musicalID == musicalID).OrderBy(r => r.name);
                returnValue = roles.ToList();
            }

            return returnValue;
        }
        public void Delete()
        {
            using (BayviewMusicalContext db = new BayviewMusicalContext())
            {
                MusicalRole mr = db.MusicalRoles.SingleOrDefault(m => m.roleID == this.roleID);
                db.DeleteObject(mr);
                db.SaveChanges();
            }

        }
        public void Save()
        {
            using (BayviewMusicalContext db = new BayviewMusicalContext())
            {
                if (this.roleID == 0)
                {
                    db.MusicalRoles.AddObject(this);
                }
                else
                {
                    MusicalRole mr = db.MusicalRoles.SingleOrDefault(r => r.roleID == this.roleID);
                    if (mr != null)
                    {
                        mr.name = this.name;
                        mr.gender = this.gender;
                        mr.grade = this.grade;
                    }
                }
                db.SaveChanges();
            }
        }
    }
    partial class AuditionDate
    {
        public AuditionDate() { }
        public AuditionDate(int dateID)
        {
            using (BayviewMusicalContext db = new BayviewMusicalContext())
            {
                var dates = (from date in db.AuditionDates
                             select date).Where(d => d.dateID == dateID).FirstOrDefault();
                this.dateID = dateID;
                if (dates != null)
                {
                    this.date = dates.date;
                    this.musicalID = dates.musicalID;
                }
            }

        }
        public static List<AuditionDate> MusicalDates(int musicalID)
        {
            List <AuditionDate> returnValue = new List<AuditionDate>();

            using (BayviewMusicalContext db = new BayviewMusicalContext())
            {
                var dates = (from date in db.AuditionDates
                             select date).Where(d => d.musicalID == musicalID).OrderBy(d => d.date);
                returnValue = dates.ToList();
            }

            return returnValue;
        }
        public void Delete()
        {
            using (BayviewMusicalContext db = new BayviewMusicalContext())
            {
                AuditionDate ad = db.AuditionDates.SingleOrDefault(a => a.dateID == this.dateID);
                db.DeleteObject(ad);
                db.SaveChanges();
            }

        }
        public void Save()
        {
            using (BayviewMusicalContext db = new BayviewMusicalContext())
            {
                if (this.dateID == 0)
                {
                    db.AuditionDates.AddObject(this);
                }
                else
                {
                    AuditionDate ad = db.AuditionDates.SingleOrDefault(d => d.dateID == this.dateID);
                    if (ad != null)
                    {
                        ad.date = this.date;
                        ad.dateID = this.dateID;
                    }
                }
                db.SaveChanges();
            }
        }
    }
    partial class AuditionTime
    {
        public AuditionTime() { }

        public AuditionTime(int TimeID)
        {
            using (BayviewMusicalContext db = new BayviewMusicalContext())
            {
                var times = (from time in db.AuditionTimes
                             select time).Where(t => t.timeID == TimeID).FirstOrDefault();
                this.timeID = TimeID;
                if (times != null)
                {
                    this.timeDescription = times.timeDescription;
                    this.signupStartDate = times.signupStartDate;
                    this.signupEndDate = times.signupEndDate;
                    this.availableSlots = times.availableSlots;
                    this.dateID = times.dateID;
                }
            }
        }
        public void Delete()
        {
            using (BayviewMusicalContext db = new BayviewMusicalContext())
            {
                AuditionTime at = db.AuditionTimes.SingleOrDefault(a => a.timeID == this.timeID);
                db.DeleteObject(at);
                db.SaveChanges();
            }

        }
        public void Save()
        {
            using (BayviewMusicalContext db = new BayviewMusicalContext())
            {
                if (this.timeID == 0)
                {
                    db.AuditionTimes.AddObject(this);
                }
                else
                {
                    AuditionTime at = db.AuditionTimes.SingleOrDefault(t => t.timeID == this.timeID);
                    if (at != null)
                    {
                        at.timeDescription = this.timeDescription;
                        at.signupStartDate = this.signupStartDate;
                        at.signupEndDate = this.signupEndDate;
                        at.availableSlots = this.availableSlots;  
                    }
                }
                db.SaveChanges();
            }
        }

        public static List<AuditionTime> TimeSlots(int auditionDateID)
        {
            List<AuditionTime> returnValue = new List<AuditionTime>();
            using (BayviewMusicalContext db = new BayviewMusicalContext())
            {
                var times = (from time in db.AuditionTimes
                             select time).Where(t => t.dateID == auditionDateID).OrderBy(t => t.timeDescription);
                returnValue = times.ToList();
            }
            return returnValue;
        }
        public int SignedUpCount()
        {
            int returnValue;

            using (BayviewMusicalContext db = new BayviewMusicalContext())
            {
                returnValue = (from time in db.StudentTimes
                               select time).Where(t => t.timeID == this.timeID).Count();
            }

            return returnValue;
        }
    }
    partial class StudentTime
    {
        public StudentTime() { }

        public StudentTime(int studentID, int musicalID)
        {
            using (BayviewMusicalContext db = new BayviewMusicalContext())
            {
                var times = (from time in db.StudentTimes
                             select time).Where(t => t.studentID == studentID && t.AuditionTime.AuditionDate.musicalID==musicalID).FirstOrDefault();
                if (times != null)
                {
                    this.studentTimeID = times.studentTimeID;
                    this.studentID = times.studentID;
                    this.timeID = times.timeID;
                }
            }
            
        }

        public bool IsAvailable()
        {
            
            
            using (BayviewMusicalContext db = new BayviewMusicalContext())
            {
                var times = (from time in db.AuditionTimes
                             select time).Where(t => t.timeID == this.timeID).FirstOrDefault();
                if (times == null)
                    return false;

                var taken = (from studenttime in db.StudentTimes
                             select studenttime).Where(st => st.timeID == this.timeID).Count();
                if (times.availableSlots == taken)
                    return false;
                else
                    return true;
            }

            
        }
        public void Save()
        {
            using (BayviewMusicalContext db = new BayviewMusicalContext())
            {
                //first delete existing student time
                var existingTimes = (from existingTime in db.StudentTimes
                                     select existingTime).Where(st => st.studentID == this.studentID).FirstOrDefault();
                if (existingTimes != null)
                {
                    db.DeleteObject(existingTimes);
                    db.SaveChanges();
                }
                //save new time

                db.StudentTimes.AddObject(this);
                db.SaveChanges();
            }
        }
        public DateTime Date()
        {
            DateTime returnValue;

            using (BayviewMusicalContext db = new BayviewMusicalContext())
            {
                var times = (from time in db.StudentTimes
                             select time).Where(st => st.studentID == this.studentID).FirstOrDefault();
                returnValue = (DateTime)times.AuditionTime.AuditionDate.date;
            }

            return returnValue;
        }
        public string TimeName()
        {
            string returnValue;
            using (BayviewMusicalContext db = new BayviewMusicalContext())
            {
                var times = (from time in db.StudentTimes
                             select time).Where(st => st.studentID == this.studentID).FirstOrDefault();
                returnValue = times.AuditionTime.timeDescription;
            }
            return returnValue;
        }
    }
    partial class Account
    {
        public Account() { }

        public Account(int accountID)
        {
            using (BayviewMusicalContext db = new BayviewMusicalContext())
            {
                var accounts = (from account in db.Accounts
                                select account).Where(a => a.AccountID == accountID).FirstOrDefault();
                this.AccountID = accountID;
                if (accounts != null)
                {
                    this.UserName = accounts.UserName;
                    this.Password = accounts.Password;
                }
            }
        }

        public Account(string userName)
        {
            using (BayviewMusicalContext db = new BayviewMusicalContext())
            {
                var accounts = (from account in db.Accounts
                                select account).Where(a => a.UserName == userName).FirstOrDefault();
                
                if (accounts != null)
                {
                    this.AccountID = accounts.AccountID;
                    this.UserName = userName;
                    this.Password = accounts.Password;
                }
            }
        }
        public void Save()
        {
            using (BayviewMusicalContext db = new BayviewMusicalContext())
            {
                if (this.AccountID == 0)
                {
                    db.Accounts.AddObject(this);
                }
                else
                {
                    Account act = db.Accounts.SingleOrDefault(a => a.AccountID == this.AccountID);
                    if (act != null)
                    {
                        act.UserName = this.UserName;
                        act.Password = this.Password;
                    }
                }
                db.SaveChanges();
            }
        }
    }
}