import * as React from "react";
import { LogoContainerStyled, LogoImgStyled } from "./styled";

class Example extends React.Component<any, any>
{
    render(): React.ReactElement {
        return (
            <LogoContainerStyled>
                <LogoImgStyled src={"/assets/logo.png"} width={500} height={250} alt={"NEST JS + REACT"}/>
            </LogoContainerStyled>
        );
    }
}

export default Example