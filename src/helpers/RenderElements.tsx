import * as React from "react";
import { renderToString } from "react-dom/server";
import { ServerStyleSheet } from "styled-components";

export interface renderResults {
    html: string;
    styled: string;
}

export const RenderElement = function (Element): renderResults
{
    const data:renderResults =  {
        html: "",
        styled: ""
    };
    const sheet = new ServerStyleSheet();

    try {
        data.html = renderToString(sheet.collectStyles(<Element />))
        data.styled =  sheet.getStyleTags();

        return data;
    } catch (error) {
        // handle error
        console.error(error)
    } finally {
        sheet.seal()
    }

    return data;
}
