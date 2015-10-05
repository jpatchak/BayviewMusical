using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using BayviewMusical.Models;
using System.Web.Security;
namespace BayviewMusical.Controllers
{
    public class AdminController : Controller
    {
        //
        // GET: /Admin/

        public ActionResult Login()
        {
            return View();
        }
        [Authorize]
        public ActionResult AuditionDates(string musicalID)
        {
            AdminDatesViewModel m = new AdminDatesViewModel(Int32.Parse(musicalID));
            

            return View(m);
        }
        [Authorize]
        public ActionResult Roles(string musicalID)
        {
            AdminRolesViewModel m = new AdminRolesViewModel(Int32.Parse(musicalID));

            return View(m);

        }
        [Authorize]
        public ActionResult Students(string musicalID)
        {
            AdminStudentViewModel m = new AdminStudentViewModel();
            m.MusicalID = Int32.Parse(musicalID);

            return View(m);
        }
        [Authorize]
        public ActionResult StudentSearch(string musicalID, string firstName, string lastName, string code, string gender, string grade, string roleID, string dateID, string timeID)
        {
            AdminStudentSearchViewModel m = new AdminStudentSearchViewModel();
            m.SearchResults = StudentSearchResult.StudentSearchResults(musicalID: Int32.Parse(musicalID),
                                                                        firstName: firstName,
                                                                        lastName: lastName,
                                                                        code: code,
                                                                        gender: gender,
                                                                        grade: grade,
                                                                        roleId: Int32.Parse(roleID),
                                                                        dateID: Int32.Parse(dateID),
                                                                        timeID: Int32.Parse(timeID));

            return View(m);
        }

        [HttpPost]
        [Authorize]
        public JsonResult DeleteStudent(string code)
        {
            Student s = new Student(code, Musical.CurrentMusical().musicalID);

            s.Delete();

            return Json(new { result = "Delete Successful" }, JsonRequestBehavior.AllowGet);
        }
        [Authorize]
        public ActionResult GetTimeSlots(string dateID)
        {
            var TimeSlots = from ts in TimeSlot.AllTimeSlots(Int32.Parse(dateID))
                            select new SelectListItem
                            {
                                Text = ts.Name,
                                Value = ts.ID.ToString()
                            };
            return Json(TimeSlots, JsonRequestBehavior.AllowGet);
        }
        [Authorize] 
        public ActionResult Home(string musicalID)
        {
            if(musicalID==null)
                musicalID = Musical.CurrentMusical().musicalID.ToString();

            AdminHomeViewModel m = new AdminHomeViewModel();

            Musical myMusical = new Musical(Int32.Parse(musicalID));

            m.MusicalID = myMusical.musicalID;
            if (m.MusicalID != 0)
            {
                m.MusicalName = myMusical.name;
                m.ExpiredMessage = myMusical.expiredMessage;
                m.ConfirmationMessage = myMusical.confirmationMessage;
                m.SignUpStartDate = ((DateTime)myMusical.signupStartDate).ToString("MM/dd/yyyy");
                m.SignUpEndDate = ((DateTime)myMusical.signupEndDate).ToString("MM/dd/yyyy");
            }

            return View(m);
        }
        [Authorize]
        public ActionResult SaveStudent(AdminEditstudentViewModel m)
        {
            Student myStudent = new Student();
            try
            {
                if (ModelState.IsValid)
                {
                    myStudent.code = m.Code;
                    myStudent.firstName = m.FirstName;
                    myStudent.lastName = m.LastName;
                    myStudent.email = m.Email;
                    myStudent.grade = m.Grade;
                    myStudent.gender = m.Gender;
                    myStudent.musicalID = m.MusicalID;
                    myStudent.studentID = m.StudentID;

                    List<int> DesiredRoles = new List<int>();
                    DesiredRoles.Add(m.RoleID);

                    myStudent.Save(DesiredRoles);
                    StudentTime st = new StudentTime();
                    st.studentID = myStudent.studentID;
                    st.timeID = m.TimeID;

                    if (!st.IsAvailable())
                        throw new Exception("Too slow! This time has filled up. Please select another time.");

                    st.Save();

                }
                else
                {
                    m.RoleList = MusicalRole.AllRoles(m.MusicalID).Select(r => new SelectListItem()
                    {
                        Text = r.name,
                        Value = r.roleID.ToString()
                    });

                    m.DateList = AuditionDate.MusicalDates(m.MusicalID).Select(r => new SelectListItem()
                    {
                        Text = ((DateTime)r.date).ToString("MM/dd/yyyy"),
                        Value = r.dateID.ToString()
                    });

                    if (m.DateID == 0)
                        m.DateID = m.DateList.Select(r => Int32.Parse(r.Value)).FirstOrDefault();

                    m.TimeList = AuditionTime.TimeSlots(m.DateID).Select(t => new SelectListItem()
                    {
                        Text = t.timeDescription,
                        Value = t.timeID.ToString()
                    });
                    return View("EditStudent", m);
                }

            }
            catch (Exception ex)
            {
                m.RoleList = MusicalRole.AllRoles(m.MusicalID).Select(r => new SelectListItem()
                {
                    Text = r.name,
                    Value = r.roleID.ToString()
                });

                m.DateList = AuditionDate.MusicalDates(m.MusicalID).Select(r => new SelectListItem()
                {
                    Text = ((DateTime)r.date).ToString("MM/dd/yyyy"),
                    Value = r.dateID.ToString()
                });

                if (m.DateID == 0)
                    m.DateID = m.DateList.Select(r => Int32.Parse(r.Value)).FirstOrDefault();

                m.TimeList = AuditionTime.TimeSlots(m.DateID).Select(t => new SelectListItem()
                {
                    Text = t.timeDescription,
                    Value = t.timeID.ToString()
                });
                ModelState.AddModelError("", ex.Message);
                return View("EditStudent", m);
            }
            return RedirectToRoute("AdminStudents", new { musicalID = myStudent.musicalID });
        }
        [Authorize]
        public ActionResult EditStudent(string musicalID, string studentID)
        {
            AdminEditstudentViewModel m = new AdminEditstudentViewModel();

            Student stu = new Student(Int32.Parse(studentID));
            m.Code = stu.code;
            m.Email = stu.email;
            m.FirstName = stu.firstName;
            m.LastName = stu.lastName;
            m.StudentID = stu.studentID;
            m.MusicalID = Int32.Parse(musicalID);
            m.Gender = stu.gender;
            m.Grade = stu.grade;

            StudentDateTime sdt = new StudentDateTime(Int32.Parse(studentID));
            m.DateID = sdt.DateID;
            m.TimeID = sdt.TimeID;
            m.RoleID = stu.RoleIDs(m.MusicalID).Select(r => r).FirstOrDefault();

            m.RoleList = MusicalRole.AllRoles(Int32.Parse(musicalID)).Select(r => new SelectListItem()
            {
                Text = r.name,
                Value = r.roleID.ToString()
            });
            
            m.DateList = AuditionDate.MusicalDates(Int32.Parse(musicalID)).Select(r => new SelectListItem()
            {
                Text=((DateTime)r.date).ToString("MM/dd/yyyy"),
                Value = r.dateID.ToString()
            });

            if (m.DateID == 0)
                m.DateID = m.DateList.Select(r => Int32.Parse(r.Value)).FirstOrDefault();

            m.TimeList = AuditionTime.TimeSlots(m.DateID).Select(t => new SelectListItem()
            {
                Text = t.timeDescription,
                Value = t.timeID.ToString()
            });

            return View(m);
        }
        [Authorize]
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult SaveMusical(AdminHomeViewModel m)
        {
            Musical myMusical = new Musical();
            try
            {
                if (ModelState.IsValid)
                {
                    //TODO: date validation
                    //TODO: date format validation

                    myMusical.musicalID = m.MusicalID;
                    myMusical.name = m.MusicalName;
                    myMusical.signupStartDate = DateTime.Parse(m.SignUpStartDate);
                    myMusical.signupEndDate = DateTime.Parse(m.SignUpEndDate);
                    myMusical.expiredMessage = m.ExpiredMessage;
                    myMusical.confirmationMessage = m.ConfirmationMessage;
                    myMusical.Save();
                }
                else
                {
                    return View("Home", m);
                }

            }
            catch (Exception ex)
            {
                ModelState.AddModelError("", ex.Message);
                return View("Home", m);
            }
            return RedirectToRoute("AdminHome", new { musicalID = myMusical.musicalID });
            
        }
        [Authorize]
        public ActionResult EditAuditionTime(int musicalID, int dateID, int timeID)
        {
            AuditionTime at = new AuditionTime(timeID);
            AdminEditAuditionTime m = new AdminEditAuditionTime();
            m.MusicalID = musicalID;
            m.DateID = dateID;
            m.TimeID = timeID;
            if(at.timeID!=0)
            {
                m.TimeDescription = at.timeDescription;
                m.SignUpStartDate = ((DateTime)at.signupStartDate).ToString("MM/dd/yyyy");
                m.SignUpEndDate = ((DateTime)at.signupEndDate).ToString("MM/dd/yyyy");
                m.Capacity = Int32.Parse(at.availableSlots.ToString());
            };

            return View(m);
        }
        [Authorize]
        [HttpPost]
        public ActionResult SaveAuditionTime(AdminEditAuditionTime m)
        {
            AuditionTime myAuditionTime = new AuditionTime();
            try
            {
                if (ModelState.IsValid)
                {
                    myAuditionTime.timeID = m.TimeID;
                    myAuditionTime.availableSlots = m.Capacity;
                    myAuditionTime.dateID = m.DateID;
                    myAuditionTime.timeDescription = m.TimeDescription;
                    myAuditionTime.signupStartDate = DateTime.Parse(m.SignUpStartDate);
                    myAuditionTime.signupEndDate = DateTime.Parse(m.SignUpEndDate);
                    myAuditionTime.Save();
                }
                else
                {
                    return View("EditAuditionTime", m);
                }
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("", ex.Message);
                return View("EditAuditionTime", m);
            }
            return RedirectToRoute("AdminDates", new { musicalID = m.MusicalID });
        }
        [Authorize]
        [HttpPost]
        public JsonResult DeleteAuditionTime(int timeID)
        {
            AuditionTime at = new AuditionTime(timeID);

            at.Delete();

            return Json(new {result="Delete Successful"}, JsonRequestBehavior.AllowGet);

        }
        [Authorize]
        public ActionResult EditAuditionDate(int musicalID, int dateID)
        {
            AuditionDate ad = new AuditionDate(dateID);
            AdminEditAuditionDate m = new AdminEditAuditionDate();
            m.MusicalID = musicalID;
            m.DateID = dateID;
            if (ad.dateID != 0)
            {
                m.Date = ((DateTime)ad.date).ToString("MM/dd/yyyy");
            };

            return View(m);
        }
        [Authorize]
        [HttpPost]
        public ActionResult SaveAuditionDate(AdminEditAuditionDate m)
        {
            AuditionDate myAuditionDate = new AuditionDate();
            try
            {
                if (ModelState.IsValid)
                {
                    myAuditionDate.dateID = m.DateID;
                    myAuditionDate.musicalID = m.MusicalID;
                    myAuditionDate.date = DateTime.Parse(m.Date);
                    myAuditionDate.Save();
                }
                else
                {
                    return View("EditAuditionDate", m);
                }

            }
            catch (Exception ex)
            {
                ModelState.AddModelError("", ex.Message);
                return View("EditAuditionDate", m);
            }
            return RedirectToRoute("AdminDates", new { musicalID = m.MusicalID });
        }
        [Authorize]
        [HttpPost]
        public JsonResult DeleteAuditionDate(int dateID)
        {
            AuditionDate ad = new AuditionDate(dateID);

            ad.Delete();

            return Json(new { result = "Delete Successful" }, JsonRequestBehavior.AllowGet);

        }
        [Authorize]
        public ActionResult EditMusicalRole(int musicalID, int roleID)
        {
            MusicalRole mr = new MusicalRole(roleID);
            AdminEditMusicalRole m = new AdminEditMusicalRole();
            m.MusicalID = musicalID;
            m.RoleID = roleID;
            if (mr.roleID != 0)
            {
                m.RoleName = mr.name;
                m.Gender = mr.gender;
                m.Grade = mr.grade;
            };

            return View(m);
        }
        [Authorize]
        public ActionResult MyAccount(int musicalID)
        {
            Account a = new Account(System.Web.HttpContext.Current.User.Identity.Name);
            AdminMyAccount m = new AdminMyAccount();
            m.MusicalID = musicalID;
            
            if (a.AccountID != 0)
            {
                m.AccountID = a.AccountID;
                m.UserName = a.UserName;
            };

            return View(m);
        }
        [Authorize]
        [HttpPost]
        public ActionResult SaveAccount(AdminMyAccount m)
        {
            Account myAccount = new Account();
            try
            {
                if (ModelState.IsValid)
                {
                    if (m.Password != m.RetypePassword)
                        throw new Exception("Password and Retype Password must match.");

                    myAccount.AccountID = m.AccountID;
                    myAccount.UserName = m.UserName;
                    myAccount.Password = PasswordHash.CreateHash(m.Password);
                    myAccount.Save();
                }
                else
                {
                    return View("MyAccount", m);
                }
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("", ex.Message);
                return View("MyAccount", m);
            }
            return RedirectToRoute("AdminHome", new { musicalID = m.MusicalID });
        }

        [Authorize]
        [HttpPost]
        public ActionResult SaveMusicalRole(AdminEditMusicalRole m)
        {
            MusicalRole myMusicalRole = new MusicalRole();
            try
            {
                if (ModelState.IsValid)
                {
                    myMusicalRole.roleID = m.RoleID;
                    myMusicalRole.name = m.RoleName;
                    myMusicalRole.musicalID = m.MusicalID;
                    myMusicalRole.gender = m.Gender;
                    myMusicalRole.grade = m.Grade;
                    myMusicalRole.Save();
                }
                else
                {
                    return View("EditMusicalRole", m);
                }
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("", ex.Message);
                return View("EditMusicalRole", m);
            }
            return RedirectToRoute("AdminRoles", new { musicalID = m.MusicalID });
        }
        [Authorize]
        [HttpPost]
        public JsonResult DeleteMusicalRole(int roleID)
        {
            MusicalRole mr = new MusicalRole(roleID);

            mr.Delete();

            return Json(new { result = "Delete Successful" }, JsonRequestBehavior.AllowGet);

        }

        [Authorize]
        public ActionResult TopNavigation(int musicalID)
        {
            AdminTopNavigationViewModel m = new AdminTopNavigationViewModel();
            m.Musical = new Musical(musicalID);
            m.AllMusicals = Musical.AllMusicals();
            return View("_TopNavigation", m);
        }
        public ActionResult LogOut()
        {
            FormsAuthentication.SignOut();
            return RedirectToRoute("AdminLogin");
        }

        [HttpPost]
        public ActionResult DoLogin(AdminLoginViewModel m)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    Account a = new Account(m.UserName);
                    if (PasswordHash.ValidatePassword(m.Password, a.Password))
                    {
                        FormsAuthentication.SetAuthCookie(m.UserName, true);
                        return RedirectToRoute("AdminHome", new AdminHomeViewModel() { MusicalID = Musical.CurrentMusical().musicalID });
                    }

                    else
                    {
                        m.Password = null;
                        throw new Exception("The username or password you provided is incorrect.");
                    }
                }
                else
                {
                    return View("Login", m);
                }

            }
            catch (Exception ex)
            {
                ModelState.AddModelError("", ex.Message);
                return View("Login", m);
            }
        }
    }
}
