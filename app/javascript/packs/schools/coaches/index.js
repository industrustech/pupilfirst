import "schools/coaches/index.css";
import "schools/shared/shared.css";
import * as React from "react";
import * as ReactDOM from "react-dom";
import { jsComponent } from "../../../schools/coaches/components/SA_CoachesPanel.bs";

document.addEventListener("turbolinks:load", () => {
  const root = document.getElementById("sa-coaches-panel");
  const props = JSON.parse(root.dataset.props);
  ReactDOM.render(React.createElement(jsComponent, props), root);
});