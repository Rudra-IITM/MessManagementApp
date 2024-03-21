import { Link, useNavigate } from "react-router-dom";
import Security from "../images/otp.svg";
import { useState } from "react";
import axios from "axios";
import { getToken } from "../utils/getToken";

export default function GetOTP() {

  const [email, setEmail] = useState("");
  const [username, setUsername] = useState("");
  const navigate = useNavigate();
  const token = getToken();


  if (token) {
    navigate("/home");
  }

  const handleSubmit = async () => {
    try {
      const { status, data } = await axios.post(
        `${import.meta.env.VITE_BACKEND_URI}/admin/send/otp`,
        {
          email,
          username,
        }
      );

      console.log(data);

      await window.localStorage.setItem(
        "user-info",
        JSON.stringify({ email, username })
      );

      navigate("/signup");

      if (status === 200) {
        console.log("Data saved successfully");
      } else {
        console.error("Failed to save data");
      }
    } catch (error) {
      alert(error.response.data.message);
      console.error("Error:", error);
    }
  };

  return (
    <div className="bg-white h-lvh flex justify-center items-center">
      <div className="bg-white w-4/6 h-5/6 w-70 flex flex-row justify-space-between items-center rounded shadow-[0_35px_60px_-15px_rgba(0,0,0,0.3)]">
        <div className="image w-1/2 bg-[#012169] flex justify-center items-center ml-4">
          <img className="w-full" src={Security} alt="not found" />
        </div>
        <div className="h-full w-1/2 flex flex-col justify-center items-center">
          <h2 className="text-3xl font-bold">OTP Verification</h2>
          <form className="w-4/5 font-medium">
            <div className="form-field mt-10 ">
              <div className="mb-1">Username</div>
              <div className="flex rounded-lg shadow-sm">
                <span className="px-4 inline-flex items-center min-w-fit rounded-s-md border border-e-0 border-gray-200 bg-gray-50 text-sm text-gray-500 dark:bg-gray-700 dark:border-gray-700 dark:text-gray-400">
                  <i className="bi bi-envelope-at-fill">
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      width="16"
                      height="16"
                      fill="currentColor"
                      className="bi bi-person-fill"
                      viewBox="0 0 16 16"
                    >
                      <path d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6" />
                    </svg>
                  </i>
                </span>
                <input
                  type="text"
                  className="px-4 py-3 pe-11 block w-full border-gray-200 shadow-sm rounded-e-lg text-sm focus:z-10 focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none dark:bg-slate-900 dark:border-gray-700 dark:text-gray-400 dark:focus:ring-gray-600"
                  placeholder="enter your username"
                  onChange={(e) => setUsername((prev) => e.target.value)}
                />
              </div>
            </div>
            <div className="form-field mt-5">
              <div className="mb-1">Email Id</div>
              <div className="flex rounded-lg shadow-sm">
                <span className="px-4 inline-flex items-center min-w-fit rounded-s-md border border-e-0 border-gray-200 bg-gray-50 text-sm text-gray-500 dark:bg-gray-700 dark:border-gray-700 dark:text-gray-400">
                  <i className="bi bi-envelope-at-fill">
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      width="16"
                      height="16"
                      fill="currentColor"
                      className="bi bi-envelope-at-fill"
                      viewBox="0 0 16 16"
                    >
                      <path d="M2 2A2 2 0 0 0 .05 3.555L8 8.414l7.95-4.859A2 2 0 0 0 14 2zm-2 9.8V4.698l5.803 3.546zm6.761-2.97-6.57 4.026A2 2 0 0 0 2 14h6.256A4.5 4.5 0 0 1 8 12.5a4.49 4.49 0 0 1 1.606-3.446l-.367-.225L8 9.586zM16 9.671V4.697l-5.803 3.546.338.208A4.5 4.5 0 0 1 12.5 8c1.414 0 2.675.652 3.5 1.671" />
                      <path d="M15.834 12.244c0 1.168-.577 2.025-1.587 2.025-.503 0-1.002-.228-1.12-.648h-.043c-.118.416-.543.643-1.015.643-.77 0-1.259-.542-1.259-1.434v-.529c0-.844.481-1.4 1.26-1.4.585 0 .87.333.953.63h.03v-.568h.905v2.19c0 .272.18.42.411.42.315 0 .639-.415.639-1.39v-.118c0-1.277-.95-2.326-2.484-2.326h-.04c-1.582 0-2.64 1.067-2.64 2.724v.157c0 1.867 1.237 2.654 2.57 2.654h.045c.507 0 .935-.07 1.18-.18v.731c-.219.1-.643.175-1.237.175h-.044C10.438 16 9 14.82 9 12.646v-.214C9 10.36 10.421 9 12.485 9h.035c2.12 0 3.314 1.43 3.314 3.034zm-4.04.21v.227c0 .586.227.8.581.8.31 0 .564-.17.564-.743v-.367c0-.516-.275-.708-.572-.708-.346 0-.573.245-.573.791" />
                    </svg>
                  </i>
                </span>
                <input
                  type="text"
                  className="py-3 px-4 pe-11 block w-full border-gray-200 shadow-sm rounded-e-lg text-sm focus:z-10 focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none dark:bg-slate-900 dark:border-gray-700 dark:text-gray-400 dark:focus:ring-gray-600"
                  onChange={(e) => setEmail((prev) => e.target.value)}
                  placeholder="userid@gmail.com"
                />
              </div>
            </div>

            <div className="w-full flex justify-center my-5">
              <button
                type="button"
                className=" h-9 bg-[#012169] rounded-md w-48 text-white"
                onClick={async () => await handleSubmit()}
              >
                Send OTP
              </button>
            </div>
          </form>
          <p className="flex justify-center w-4/5 border-t-4 border-dashed">
            Already have a account?--
            <Link className="text-blue-600 underline" to="/login">
              Log in
            </Link>
          </p>
        </div>
      </div>
    </div>
  );
}
