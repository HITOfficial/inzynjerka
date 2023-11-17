import React,{useEffect} from 'react';
import {
  BrowserRouter as Router,
  Route,
  Switch,
  useLocation,
} from 'react-router-dom';
import ModelSettings from './model-settings/ModelSettings';
import QAndAPage from './q-and-a/QAndAPage';
import {Box} from 'theme-ui';
import QuestionStatistics from "./question-statistics/QuestionStatistics";

export const MODEL_URL = 'http://localhost:8080';
export const getAccessToken = (iframeRef: any) => {
  if (iframeRef.current) {
    const iframeContentWindow = iframeRef.current.contentWindow;
    if (iframeContentWindow) {
      const accessToken = window.localStorage.getItem(
        '__PAPERCUPS____AUTH_TOKENS__'
      );
      const token = JSON.parse(accessToken || '{}');
      return token.token;
    }
  }
  return '';
};

const Model = () => {
  return (
    <Box
      sx={{
        flex: 1,
        overflow: 'hidden',
      }}
    >
      <Router>
        <Switch>
          <Route exactpath={`/model/model-settings`} component={ModelSettings} />
          <Route exact path={`/model/q-and-a`} component={QAndAPage} />
          <Route exact path={`/question-statistics`} component={QuestionStatistics} />
        </Switch>
      </Router>
    </Box>
  );
};

export default Model;
