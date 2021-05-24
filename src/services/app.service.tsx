import { Injectable } from '@nestjs/common';
import Logo from "../components/logo/logo";
import { RenderElement } from "../helpers/RenderElements";
import { GlobalStyle } from "../helpers/GlobalStyled";


@Injectable()
export class AppService {
    getLogo(): string
    {
        const data = RenderElement(Logo);

        return data.html + data.styled;
    }

    getGlobalStyle(): string
    {
        const data = RenderElement(GlobalStyle);

        return data.html + data.styled;
    }
}
