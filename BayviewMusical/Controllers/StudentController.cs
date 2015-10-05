using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using BayviewMusical.Models;
namespace BayviewMusical.Controllers
{
    public class StudentController : Controller
    {
        //
        // GET: /Student/

        public ActionResult SignUp()
        {
            StudentSignUpModel m = new StudentSignUpModel();
            
            return View(m);
        }

        public ActionResult DesiredRoles(string studentCode, string gender, string grade)
        {

            Student stu = new Student(studentCode, Musical.CurrentMusical().musicalID);

            List<int> studentRoles = stu.RoleIDs(Musical.CurrentMusical().musicalID);
            List<MusicalRole> musicalRoles = MusicalRole.AvailableRoles(Musical.CurrentMusical().musicalID, gender, grade);
            List<RoleCheckbox> checkBoxes = new List<RoleCheckbox>();

            foreach (MusicalRole role in musicalRoles)
            {
                RoleCheckbox chk = new RoleCheckbox() { RoleID = role.roleID, RoleName = role.name, IsChecked = false };
                checkBoxes.Add(chk);
            }

            //foreach (RoleCheckbox chk in checkBoxes.Where(r => studentRoles.Contains(r.RoleID)))
            foreach (RoleCheckbox chk in checkBoxes.Where(r => studentRoles.Contains(r.RoleID)))
            {
                chk.IsChecked = true;
            }

            DesiredRolesViewModel m = new DesiredRolesViewModel();

            m.DesiredRoles = checkBoxes.ToArray();

            return View("_DesiredRoles", m);
            
        }
        public ActionResult MyInfo(string code)
        {
            Student stu = new Student(code, Musical.CurrentMusical().musicalID);
            StudentMyInfoModel m = new StudentMyInfoModel()
            {
                Code = code,
                Email = stu.email,
                FirstName = stu.firstName,
                LastName = stu.lastName,
                Gender = stu.gender,
                Grade = stu.grade
            };

            return View(m);
        }
        public ActionResult MyTime(string code)
        {
            StudentMyTimeModel m = new StudentMyTimeModel(code);

            return View(m);
        }

        public ActionResult Confirmation(string Code)
        {
            int studentID = new Student(Code, Musical.CurrentMusical().musicalID).studentID;

            StudentConfirmationModel m = new StudentConfirmationModel();
            m.ConfirmationMessage = Musical.CurrentMusical().confirmationMessage;
            m.Code = Code;

            StudentTime st = new StudentTime(studentID, Musical.CurrentMusical().musicalID);

            DateTime myDate = st.Date();

            string dateSuffix = (myDate.Day % 10 == 1 && myDate.Day != 11) ? "st"
            : (myDate.Day % 10 == 2 && myDate.Day != 12) ? "nd"
            : (myDate.Day % 10 == 3 && myDate.Day != 13) ? "rd"
            : "th";

            m.AuditionDate = st.Date().ToString("dddd, MMMM d") + dateSuffix; 
            m.AuditionGroup = st.TimeName();

            return View(m);
        }

        [HttpPost]
        public ActionResult SubmitMyTime(string Code, string timeID)
        {
            StudentMyTimeModel m = new StudentMyTimeModel(Code);

            try
            {
                if (ModelState.IsValid)
                {
                    StudentTime st = new StudentTime();
                    st.studentID = new Student(Code, Musical.CurrentMusical().musicalID).studentID;
                    st.timeID = Int32.Parse(timeID);

                    if (!st.IsAvailable())
                        throw new Exception("Too slow! This time has filled up. Please select another time.");

                    st.Save();

                    return RedirectToRoute("StudentConfirmation", new { Code = Code });
                }
                else
                {
                    return View("MyTime", m);
                }
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("", ex.Message);
                return View("MyTime", m);
            }

        }
        [HttpPost]
        public ActionResult SubmitMyInfo(StudentMyInfoModel m)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    Student s = new Student(m.Code, Musical.CurrentMusical().musicalID);

                    s.code = m.Code;
                    s.firstName = m.FirstName;
                    s.lastName = m.LastName;
                    s.email = m.Email;
                    s.gender = m.Gender;
                    s.grade = m.Grade;
                    s.musicalID = Musical.CurrentMusical().musicalID;

                    List<int> DesiredRoleList = new List<int>();
                    if (m.DesiredRoles != null)
                        DesiredRoleList = m.DesiredRoles.ToList();

                    s.Save(DesiredRoleList);

                    return RedirectToRoute("StudentTime", new { code = s.code });
                }
                else
                {
                    return View("MyInfo", m);
                }
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("", ex.Message);
                return View("MyInfo", m);
            }
        }
        [HttpPost]
        public ActionResult SubmitCode(StudentSignUpModel m)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    StudentCode c = new StudentCode();
                    c.Code=m.code;
                    if (!c.IsValid())
                    { throw new Exception("Invalid Code."); }

                    //enable below code to disallow returning logins.
                    //if (c.IsClaimed())
                    //{ throw new Exception("This code has already been used to sign up."); }

                    Musical cm = Musical.CurrentMusical();

                    if (DateTime.Today.Date > cm.signupEndDate)
                    {
                        throw new Exception(cm.expiredMessage);
                    }

                    if (DateTime.Today.Date < cm.signupStartDate)
                    {
                        throw new Exception("The sign up period has not yet started. Please check back on " + ((DateTime)cm.signupStartDate).ToString("MM/dd/yyyy") + ".");
                    }
                    
                    return RedirectToRoute("StudentInfo", new { code = c.Code });
                }
                else
                {
                    return View("SignUp", m.code);
                }
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("", ex.Message);
                return View("SignUp", m);
            }
        }
    }
}
