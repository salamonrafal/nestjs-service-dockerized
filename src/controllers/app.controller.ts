import { Controller, Get, Render } from '@nestjs/common';
import { AppService } from '../services/app.service';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get()
  @Render('welcome.hbs')
  root() {
    return {
      logo: this.appService.getLogo(),
      globalCss: this.appService.getGlobalStyle(),
    };
  }
}
