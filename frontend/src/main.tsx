import React from "react";
import ReactDOM from "react-dom/client";
import App from "./App";
import "./theme/theme.css";
import "./app.css";
import "./panel/panel.css";
import "./legions/legions.css";
import "./filters/filters.css";
import "./graph/legend.css";

ReactDOM.createRoot(document.getElementById("root")!).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>,
);
